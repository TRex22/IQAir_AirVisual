module IqairAirvisual
  class Client
    include ::IqairAirvisual::Community

    # TODO: Air quality guidelines
    # TODO: Units breakdown
    # TODO: Return codes
    # https://api-docs.iqair.com/?version=latest
    # Below are a few example of return codes you may get. This list is not exhaustive.
    # success: returned when JSON file was generated successfully.
    # call_limit_reached: returned when minute/monthly limit is reached.
    # api_key_expired: returned when API key is expired.
    # incorrect_api_key: returned when using wrong API key.
    # ip_location_failed: returned when service is unable to locate IP address of request.
    # no_nearest_station: returned when there is no nearest station within specified radius.
    # feature_not_available: returned when call requests a feature that is not available in chosen subscription plan.
    # too_many_requests: returned when more than 10 calls per second are made.

    attr_reader :api_key,
      :base_path,
      :port,
      :login_response,
      :raw_cookie,
      :expiry

    def initialize(api_key:, base_path: 'http://api.airvisual.com/v2', port: 80)
      @api_key = api_key
      @base_path = base_path
      @port = port
    end

    def self.compatible_api_version
      'v2'
    end

    # This is the version of the API docs this client was built off-of
    def self.api_version
      'v2 2021-04-18'
    end

    private

    def authorise_and_send(http_method:, path:, payload: {}, params: {})
      params.merge!({ key: api_key })

      start_time = get_micro_second_time

      response = HTTParty.send(
        http_method.to_sym,
        construct_base_path(path, params),
        body: payload,
        headers: { 'Content-Type': 'application/json' },
        port: port,
        format: :json
      )

      end_time = get_micro_second_time
      construct_response_object(response, path, start_time, end_time)
    end

    def construct_response_object(response, path, start_time, end_time)
      {
        'body' => parse_body(response, path),
        'headers' => response.headers,
        'metadata' => construct_metadata(response, start_time, end_time)
      }
    end

    def construct_metadata(response, start_time, end_time)
      total_time = end_time - start_time

      {
        'start_time' => start_time,
        'end_time' => end_time,
        'total_time' => total_time
      }
    end

    def body_is_present?(response)
      !body_is_missing?(response)
    end

    def body_is_missing?(response)
      response.body.nil? || response.body.empty?
    end

    def parse_body(response, path)
      parsed_response = JSON.parse(response.body) # Purposely not using HTTParty

      if parsed_response.dig(path.to_s)
        parsed_response.dig(path.to_s)
      else
        parsed_response
      end
    rescue JSON::ParserError => _e
      response.body
    end

    def parse_cookie(set_cookie_str, key)
      value = nil
      expiry = nil

      set_cookie_str.each do |item|
        if item.include?(key)
          value = item.split('; ').first.split('=').last

          if item.include?('Expires') || item.include?('expires')
            item.split('; ').each do |sub_item|
              if sub_item.include?('Expires') || sub_item.include?('expires')
                expiry = Time.parse(sub_item.gsub('expires=', '').gsub('Expires=', ''))
              end
            end
          end
        end
      end

      [value, expiry]
    end

    def process_cookies
      # Cookies are always a single string separated by spaces
      raw_cookie.map { |item| item.split('; ').first }.join('; ')
    end

    def get_micro_second_time
      (Time.now.to_f * 1000000).to_i
    end

    def construct_base_path(path, params)
      constructed_path = "#{base_path}/#{path}"

      if params == {}
        constructed_path
      else
        "#{constructed_path}?#{process_params(params)}"
      end
    end

    def process_params(params)
      params.keys.map { |key| "#{key}=#{params[key]}" }.join('&')
    end
  end
end
