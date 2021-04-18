require "test_helper"

class IqairAirvisualTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil IqairAirvisual::VERSION
  end

  def test_that_the_client_has_compatible_api_version
    assert_equal 'v2', IqairAirvisual::Client.compatible_api_version
  end

  def test_that_the_client_has_api_version
    assert_equal 'v2 2021-04-18', IqairAirvisual::Client.api_version
  end
end
