module IqairAirvisual
  module Constants
    BASE_PATH = 'https://api.airvisual.com/v2'
    IMAGES_PATH = 'https://airvisual.com/images/'

    # https://api-docs.iqair.com/?version=latest#important-notes
    # https://www.airnow.gov/aqi/aqi-basics/
    # https://www.weather.gov/safety/airquality-aqindex
    AQI_INDEX = {
      good: { lowest_level: 0, highest_level: 50, colour: 'green', description: 'Air quality is satisfactory, and air pollution poses little or no risk.' },
      moderate: { lowest_level: 51, highest_level: 100, colour: 'yellow', description: 'Air quality is acceptable. However, there may be a risk for some people, particularly those who are unusually sensitive to air pollution.' },
      unhealthy_for_sensitive_groups: { lowest_level: 101, highest_level: 150, colour: 'orange', description: 'Members of sensitive groups may experience health effects. The general public is less likely to be affected.' },
      unhealthy: { lowest_level: 151, highest_level: 200, colour: 'red', description: 'Some members of the general public may experience health effects; members of sensitive groups may experience more serious health effects.' },
      very_unhealthy: { lowest_level: 201, highest_level: 300, colour: 'purple', description: 'Health alert: The risk of health effects is increased for everyone.' },
      hazardous: { lowest_level: 301, highest_level: 1000, colour: 'maroon', description: 'Health warning of emergency conditions: everyone is more likely to be affected.' }
    }

    WEATHER_ICON_INDEX = {
      "01d": { filename: '01d.png', url: 'https://airvisual.com/images/01d.png', description: 'clear sky (day)' },
      "01n": { filename: '01n.png', url: 'https://airvisual.com/images/01n.png', description: 'clear sky (night)' },
      "02d": { filename: '02d.png', url: 'https://airvisual.com/images/02d.png', description: 'few clouds (day)' },
      "02n": { filename: '02n.png', url: 'https://airvisual.com/images/02n.png', description: 'few clouds (night)' },
      "03d": { filename: '03d.png', url: 'https://airvisual.com/images/03d.png', description: 'scattered clouds' },
      "04d": { filename: '04d.png', url: 'https://airvisual.com/images/04d.png', description: 'broken clouds' },
      "09d": { filename: '09d.png', url: 'https://airvisual.com/images/09d.png', description: 'shower rain' },
      "10d": { filename: '10d.png', url: 'https://airvisual.com/images/10d.png', description: 'rain (day time)' },
      "10n": { filename: '10n.png', url: 'https://airvisual.com/images/10n.png', description: 'rain (night time)' },
      "11d": { filename: '11d.png', url: 'https://airvisual.com/images/11d.png', description: 'thunderstorm' },
      "13d": { filename: '13d.png', url: 'https://airvisual.com/images/13d.png', description: 'snow' },
      "50d": { filename: '50d.png', url: 'https://airvisual.com/images/50d.png', description: 'mist' }
    }

    WEATHER_CODES = {
      ts:     "timestamp",
      aqius:  "AQI value based on US EPA standard",
      aqicn:  "AQI value based on China MEP standard",
      tp:     "temperature in Celsius",
      tp_min: "minimum temperature in Celsius",
      pr:     "atmospheric pressure in hPa",
      hu:     "humidity %",
      ws:     "wind speed (m/s)",
      wd:     "wind direction, as an angle of 360° (N=0, E=90, S=180, W=270)",
      ic:     "weather icon code, see below for icon index",
      p:      "pollutant details",
      pn:     "pollutant details",
      p1:     "pollutant details",
      p2:     "pollutant details",
      p3:     "pollutant details",
      p4:     "pollutant details",
      conc:   "concentration",
      o3:     "Ozone O3",
      n2:     "Nitrogen dioxide NO2",
      s2:     "Sulfur dioxide SO2",
      co:     "Carbon monoxide CO"
    }

    # object containing units information
    UNITS = {
      ugm3: "ug/m, Micrograms per Cubic Meter of Air",
      ppb:  "Parts per billion",
      ppm:  "Parts per million"
    }

    def calculate_aqi_range(key)
      value = AQI_INDEX[:key]
      (value.lowest_level..value.highest_level).to_a
    end
  end
end
