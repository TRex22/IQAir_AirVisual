module IqairAirvisual
  module Community
    def countries
      path = 'countries'
      authorise_and_send(http_method: :get, path: path)
    end

    def states(country_name)
      path = 'states'
      params = { country: country_name }
      authorise_and_send(http_method: :get, path: path, params: params)
    end

    def cities(country_name, state_name)
      path = 'cities'
      params = {
        country: country_name,
        state: state_name
      }
      authorise_and_send(http_method: :get, path: path, params: params)
    end

    # IP Geo-locate
    def nearest_city(latitude: nil, longitude: nil)
      if (latitude && !longitude) || (!latitude && longitude)
        raise 'Both latitude and longitude are required if GPS co-ordinates specified.'
      end

      path = 'nearest_city'

      params = {}
      if (latitude && longitude)
        params = { lat: latitude, lon: longitude }
      end

      authorise_and_send(http_method: :get, path: path, params: params)
    end

    def city(country_name, state_name, city_name)
      path = 'city'
      params = {
        country: country_name,
        state: state_name,
        city: city_name
      }

      authorise_and_send(http_method: :get, path: path, params: params)
    end
  end
end
