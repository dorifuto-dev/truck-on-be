require "rails_helper"

RSpec.describe OpenWeatherService, :vcr do
  it 'can return current weather information' do
    trail_coordinates = create(:trail, latitude: 39.2814, longitude: -106.1861)
    response = OpenWeatherService.current_weather(trail_coordinates.latitude, trail_coordinates.longitude)

    expect(response).to be_a(Hash)
    expect(response).to have_key(:current)
    expect(response[:current]).to have_key(:temp)
    expect(response[:current][:weather].first).to have_key(:description)
  end
end
