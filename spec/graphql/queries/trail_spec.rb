require 'rails_helper'

module Queries
  RSpec.describe Trail, type: :request do
    before(:each) do
      trail = create(:trail, id: 1, name: "Mosquito Pass", latitude: 39.2814, longitude: -106.1861, elevation_gain: 2874,
                      description: "test", difficulty: 0, route_type: 0, traffic: 0, nearest_city: "Leadville, Alma", distance: 16)
      trail2 = create(:trail, id: 2,  name: "Fall River Trail",  latitude: 39.8213, longitude: -105.6929, elevation_gain: 752, description: "test", difficulty: 0, route_type: 0, traffic: 0, nearest_city: "Saint Mary's", distance: 2)

    end
    describe '.resolve' do
      it 'returns all trails' do
        def query
          <<~GQL
            query {
              trails {
                id
                name
                latitude
                longitude
                elevationGain
                description
                difficulty
                routeType
                traffic
                nearestCity
                distance
              }
            }
          GQL
        end

        post '/graphql', params: { query: query }

        json = JSON.parse(response.body)
        data = json['data']['trails']
        trail1_return = { "id"=>"1",
                          "name"=>"Mosquito Pass",
                          "latitude"=>39.2814,
                          "longitude"=>-106.1861,
                          "elevationGain"=>2874,
                          "description"=>"test",
                          "difficulty"=>0,
                          "routeType"=>0,
                          "traffic"=>0,
                          "nearestCity"=>"Leadville, Alma",
                          "distance"=>16
                        }
        trail2_return = { "id"=>"2",
                          "name"=>"Fall River Trail",
                          "latitude"=>39.8213,
                          "longitude"=>-105.6929,
                          "elevationGain"=>752,
                          "description"=>
                           "test",
                          "difficulty"=>0,
                          "routeType"=>0,
                          "traffic"=>0,
                          "nearestCity"=>"Saint Mary's",
                          "distance"=>2}

        expect(data).to eq([trail1_return, trail2_return])
      end

      it 'returns only particular data about a trail' do
        def query
          <<~GQL
            query {
              trails {
                name
                latitude
                longitude
                elevationGain
                distance
              }
            }
          GQL
        end

        post '/graphql', params: { query: query }

        json = JSON.parse(response.body)
        data = json['data']['trails']
        trail1_return = { "name"=>"Mosquito Pass",
                          "latitude"=>39.2814,
                          "longitude"=>-106.1861,
                          "elevationGain"=>2874,
                          "distance"=>16
                        }
        trail2_return = { "name"=>"Fall River Trail",
                          "latitude"=>39.8213,
                          "longitude"=>-105.6929,
                          "elevationGain"=>752,
                          "distance"=>2}

        expect(data).to eq([trail1_return, trail2_return])
      end

      it 'returns only particular trail if requested' do
        def query
          <<~GQL
            query {
              trail(id: 1) {
                name
                latitude
                longitude
                elevationGain
                distance
              }
            }
          GQL
        end

        post '/graphql', params: { query: query }

        json = JSON.parse(response.body)
        data = json['data']['trail']
        trail_return = {  "name"=>"Mosquito Pass",
                          "latitude"=>39.2814,
                          "longitude"=>-106.1861,
                          "elevationGain"=>2874,
                          "distance"=>16
                        }

        expect(data).to eq(trail_return)
      end
    end
  end
end
