require 'rails_helper'

module Queries
  RSpec.describe User, type: :request do
    before(:each) do
      @user = create(:user, id: 1, name: 'Jerry Seinfeld', vehicle: 'Ford Taurus')
      create(:user, id: 2, name: 'Kramer', vehicle: 'Lincoln Continental')
    end
    describe 'users' do
      it 'returns all users' do
        def query
          <<~GQL
            query {
              users {
                id
                name
                vehicle
              }
            }
          GQL
        end

        post '/graphql', params: { query: query }

        json = JSON.parse(response.body)
        data = json['data']['users']

        user1_return = {"id"=>"1", "name"=>"Jerry Seinfeld", "vehicle"=>"Ford Taurus"}
        user2_return = {"id"=>"2", "name"=>"Kramer", "vehicle"=>"Lincoln Continental"}

        expect(data).to eq([user1_return, user2_return])
      end

      it 'returns an error if field does not exist in schema' do
        def query
          <<~GQL
            query {
              users {
                id
                name
                vehicle
                email
              }
            }
          GQL
        end

        post '/graphql', params: { query: query }

        json = JSON.parse(response.body)
        data = json['errors']

        error_return = {
                        "message"=>"Field 'email' doesn't exist on type 'User'",
                        "locations"=>[{"line"=>6, "column"=>5}],
                        "path"=>["query", "users", "email"],
                        "extensions"=>{"code"=>"undefinedField", "typeName"=>"User", "fieldName"=>"email"}
                      }

        expect(data).to eq([error_return])
      end
    end

    describe 'one user' do
      it 'returns a user by id' do
        def query
          <<~GQL
            query {
              user(id: 1) {
                name
                vehicle
              }
            }
          GQL
        end

        post '/graphql', params: { query: query }

        json = JSON.parse(response.body)
        data = json['data']['user']

        user1_return = {"name"=>"Jerry Seinfeld", "vehicle"=>"Ford Taurus"}

        expect(data).to eq(user1_return)
      end

      it 'returns empty array if there are no favorite trails' do
        def query
          <<~GQL
            query {
              user(id: 1) {
                name
                vehicle
                favorites {
                  name
                  description
                }
              }
            }
          GQL
        end

        post '/graphql', params: { query: query }

        json = JSON.parse(response.body)
        data = json['data']['user']

        user1_return = {
                        "name"=>"Jerry Seinfeld",
                        "vehicle"=>"Ford Taurus",
                        "favorites"=>[]
                        }

        expect(data).to eq(user1_return)
      end

      it 'returns users favorite trails' do
        trail = create(:trail, id: 1, name: "Mosquito Pass", latitude: 39.2814, longitude: -106.1861, elevation_gain: 2874,
                        description: "test", difficulty: 0, route_type: 0, traffic: 0, nearest_city: "Leadville, Alma", distance: 16)
        trail2 = create(:trail, id: 2,  name: "Fall River Trail",  latitude: 39.8213, longitude: -105.6929, elevation_gain: 752,
                        description: "test", difficulty: 0, route_type: 0, traffic: 0, nearest_city: "Saint Mary's", distance: 2)
        @user.trails << trail
        @user.trails << trail2

        def query
          <<~GQL
            query {
              user(id: 1) {
                name
                vehicle
                favorites {
                  name
                  description
                }
              }
            }
          GQL
        end

        post '/graphql', params: { query: query }

        json = JSON.parse(response.body)
        data = json['data']['user']

        user1_return = {
                        "name"=>"Jerry Seinfeld",
                        "vehicle"=>"Ford Taurus",
                        "favorites"=>[
                          {"name"=>"Mosquito Pass","description"=>"test"},
                          {"name"=>"Fall River Trail", "description"=>"test"}
                          ]
                        }

        expect(data).to eq(user1_return)
      end

      it 'returns an error if user cannot be found' do
        def query
          <<~GQL
            query {
              user(id: 6) {
                name
                vehicle
              }
            }
          GQL
        end

        post '/graphql', params: { query: query }

        json = JSON.parse(response.body)
        data = json['errors']

        error_return = {
                        "message"=>"User not found",
                        "locations"=>[{"line"=>2, "column"=>3}],
                        "path"=>["user"]
                      }

        expect(data).to eq([error_return])
      end

      it 'returns comments associated with user' do
        trail = create(:trail, id: 1, name: "Mosquito Pass", latitude: 39.2814, longitude: -106.1861, elevation_gain: 2874,
                        description: "test", difficulty: 0, route_type: 0, traffic: 0, nearest_city: "Leadville, Alma", distance: 16)
        trail2 = create(:trail, id: 2,  name: "Fall River Trail",  latitude: 39.8213, longitude: -105.6929, elevation_gain: 752,
                        description: "test", difficulty: 0, route_type: 0, traffic: 0, nearest_city: "Saint Mary's", distance: 2)
        Comment.create(user: @user, trail: trail, content: 'fake comment 1')
        Comment.create(user: @user, trail: trail2, content: 'fake comment 2')

        def query
          <<~GQL
            query {
              user(id: 1) {
                name
                vehicle
                comments {
                  content
                }
              }
            }
          GQL
        end

        post '/graphql', params: { query: query }

        json = JSON.parse(response.body)
        data = json['data']['user']

        user1_return = {
                        "name"=>"Jerry Seinfeld",
                        "vehicle"=>"Ford Taurus",
                        "comments"=>[
                          {"content"=>"fake comment 1"},
                          {"content"=>"fake comment 2"}
                          ]
                        }

        expect(data).to eq(user1_return)
      end

      it 'returns empty array if no comments' do
        def query
          <<~GQL
            query {
              user(id: 1) {
                name
                vehicle
                comments {
                  content
                }
              }
            }
          GQL
        end

        post '/graphql', params: { query: query }

        json = JSON.parse(response.body)
        data = json['data']['user']

        user1_return = {
                        "name"=>"Jerry Seinfeld",
                        "vehicle"=>"Ford Taurus",
                        "comments"=>[]
                        }

        expect(data).to eq(user1_return)
      end

      it 'returns a count of comments for user' do
        trail = create(:trail, id: 1, name: "Mosquito Pass", latitude: 39.2814, longitude: -106.1861, elevation_gain: 2874,
                        description: "test", difficulty: 0, route_type: 0, traffic: 0, nearest_city: "Leadville, Alma", distance: 16)
        trail2 = create(:trail, id: 2,  name: "Fall River Trail",  latitude: 39.8213, longitude: -105.6929, elevation_gain: 752,
                        description: "test", difficulty: 0, route_type: 0, traffic: 0, nearest_city: "Saint Mary's", distance: 2)
        Comment.create(user: @user, trail: trail, content: 'fake comment 1')
        Comment.create(user: @user, trail: trail2, content: 'fake comment 2')

        def query
          <<~GQL
            query {
              user(id: 1) {
                name
                vehicle
                commentCount
              }
            }
          GQL
        end

        post '/graphql', params: { query: query }

        json = JSON.parse(response.body)
        data = json['data']['user']

        user1_return = {
                        "name"=>"Jerry Seinfeld",
                        "vehicle"=>"Ford Taurus",
                        "commentCount"=>2
                        }

        expect(data).to eq(user1_return)
      end
    end
  end
end
