class WeatherFacade
  def self.weather_info(latitude, longitude)
    weather = OpenWeatherService.current_weather(latitude, longitude)
    Weather.new(weather[:current])
  end
end
