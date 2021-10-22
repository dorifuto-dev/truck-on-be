class OpenWeatherService
  def self.current_weather(latitude, longitude)
    response = Faraday.get('http://api.openweathermap.org/data/2.5/onecall') do |req|
      req.params['appid'] = ENV['OPENWEATHER_KEY']
      req.params['lat'] = latitude
      req.params['lon'] = longitude
      req.params['units'] = 'imperial'
      req.headers['Content-Type'] = 'application/json'
    end
    JSON.parse(response.body, symbolize_names: true)
  end
end
