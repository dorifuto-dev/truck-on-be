require "rails_helper"

RSpec.describe WeatherFacade, :vcr do
  it 'can return current weather information' do
    trail_coordinates = create(:trail, latitude: 39.2814, longitude: -106.1861)
    response = WeatherFacade.weather_info(trail_coordinates.latitude, trail_coordinates.longitude)

    expect(response).to be_a(Weather)
    expect(response.temp).to eq(36.46)
    expect(response.conditions).to eq('clear sky')
  end
end
