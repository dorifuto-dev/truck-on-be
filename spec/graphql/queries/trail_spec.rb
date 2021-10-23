require 'rails_helper'

module Queries
  RSpec.describe Trail, type: :request do
    before(:each) do
      @trail = create(:trail, id: 1, name: "Mosquito Pass", latitude: 39.2814, longitude: -106.1861, elevation_gain: 2874,
                      description: "test", difficulty: 0, route_type: 0, traffic: 0, nearest_city: "Leadville, Alma", distance: 16)
      trail2 = create(:trail, id: 2,  name: "Fall River Trail",  latitude: 39.8213, longitude: -105.6929, elevation_gain: 752, description: "test", difficulty: 0, route_type: 0, traffic: 0, nearest_city: "Saint Mary's", distance: 2)

    end
    describe 'trails' do
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
                          "difficulty"=>"Novice",
                          "routeType"=>"Loop",
                          "traffic"=>"Light",
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
                          "difficulty"=>"Novice",
                          "routeType"=>"Loop",
                          "traffic"=>"Light",
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

      it 'returns an error if field does not exist' do
        def query
          <<~GQL
            query {
              trails {
                name
                latitude
                longitude
                elevation_gain
                distance
              }
            }
          GQL
        end

        post '/graphql', params: { query: query }

        json = JSON.parse(response.body)
        data = json['errors']
        error_return = {
                          "message"=>"Field 'elevation_gain' doesn't exist on type 'Trail'",
                          "locations"=>[{"line"=>6, "column"=>5}],
                          "path"=>["query", "trails", "elevation_gain"],
                          "extensions"=>{"code"=>"undefinedField", "typeName"=>"Trail", "fieldName"=>"elevation_gain"}
                        }

        expect(data).to eq([error_return])
      end
    end

    describe 'one trail' do
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

      it 'returns tags associated with trail' do
        tags = create_list(:tag, 6)
        tags.each do |tag|
          TrailTag.create(trail: @trail, tag: tag)
        end

        def query
          <<~GQL
            query {
              trail(id: 1) {
                name
                latitude
                longitude
                elevationGain
                distance
                tags {
                  id
                  name
                }
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
                          "distance"=>16,
                          "tags"=>[
                            {"id"=>"1", "name"=>"#{tags.first.name}"},
                            {"id"=>"2", "name"=>"#{tags.second.name}"},
                            {"id"=>"3", "name"=>"#{tags.third.name}"},
                            {"id"=>"4", "name"=>"#{tags.fourth.name}"},
                            {"id"=>"5", "name"=>"#{tags.fifth.name}"},
                            {"id"=>"6", "name"=>"#{tags.last.name}"}]
                        }

        expect(data).to eq(trail_return)
      end

      it 'returns tags associated with trail', :vcr do
        def query
          <<~GQL
            query {
              trail(id: 1) {
                name
                latitude
                longitude
                elevationGain
                distance
                temp
                conditions
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
                          "distance"=>16,
                          "temp"=>36.46,
                          "conditions"=>"clear sky"
                        }

        expect(data).to eq(trail_return)
      end

      it 'returns an error if field does not exist' do
        def query
          <<~GQL
            query {
              trail(id: 1) {
                name
                latitude
                longitude
                elevation_Gain
                distance
                route_type
              }
            }
          GQL
        end

        post '/graphql', params: { query: query }

        json = JSON.parse(response.body)
        data = json['errors']
        error_return = {
                        "message"=>"Field 'elevation_Gain' doesn't exist on type 'Trail'",
                        "locations"=>[{"line"=>6, "column"=>5}],
                        "path"=>["query", "trail", "elevation_Gain"],
                        "extensions"=>{"code"=>"undefinedField", "typeName"=>"Trail", "fieldName"=>"elevation_Gain"}
                      }
        error_return2 = {
                        "message"=>"Field 'route_type' doesn't exist on type 'Trail'",
                        "locations"=>[{"line"=>8, "column"=>5}],
                        "path"=>["query", "trail", "route_type"],
                        "extensions"=>{"code"=>"undefinedField",
                          "typeName"=>"Trail", "fieldName"=>"route_type"}
                        }

        expect(data).to eq([error_return, error_return2])
      end

      it 'returns an error if id does not exist' do
        def query
          <<~GQL
            query {
              trail(id: 500) {
                name
                latitude
                longitude
                elevationGain
                distance
                routeType
              }
            }
          GQL
        end

        post '/graphql', params: { query: query }

        json = JSON.parse(response.body)
        data = json['errors']
        error_return = [{
                        "message"=>"Trail not found", "locations"=>[{"line"=>2, "column"=>3}],
                        "path"=>["trail"]}
                      ]

        expect(data).to eq(error_return)
        expect(json['data']).to eq(nil)
      end

      it 'returns comments associated with trail' do
        user = create(:user, id: 1, name: 'Jerry Seinfeld', vehicle: 'Ford Taurus')
        comment1 = Comment.create(trail: @trail, user: user, content: 'fake comment 1')
        comment2 = Comment.create(trail: @trail, user: user, content: 'fake comment 2')
        def query
          <<~GQL
            query {
              trail(id: 1) {
                comments {
                  content
                }
              }
            }
          GQL
        end

        post '/graphql', params: { query: query }

        json = JSON.parse(response.body)
        data = json['data']['trail']['comments']
        comment_return = [{"content"=>"fake comment 1"}, {"content"=>"fake comment 2"}]

        expect(data).to eq(comment_return)
      end

      it 'returns a count of the comments on the trail' do
        user = create(:user, id: 1, name: 'Jerry Seinfeld', vehicle: 'Ford Taurus')
        comment1 = Comment.create(trail: @trail, user: user, content: 'fake comment 1')
        comment2 = Comment.create(trail: @trail, user: user, content: 'fake comment 2')
        def query
          <<~GQL
            query {
              trail(id: 1) {
                commentCount
                comments {
                  content

                }
              }
            }
          GQL
        end

        post '/graphql', params: { query: query }

        json = JSON.parse(response.body)
        data = json['data']['trail']['commentCount']

        expect(data).to eq(2)
      end
    end
  end
end
