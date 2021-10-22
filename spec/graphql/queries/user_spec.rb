require 'rails_helper'

module Queries
  RSpec.describe User, type: :request do
    before(:each) do
      create(:user, id: 1, name: 'Jerry Seinfeld', vehicle: 'Ford Taurus')
      create(:user, id: 2, name: 'Kramer', vehicle: 'Lincoln Continental')
    end
    describe '.resolve' do
      it 'returns all users' do

        post '/graphql', params: { query: query }

        json = JSON.parse(response.body)
        data = json['data']['users']

        user1_return = {"id"=>"1", "name"=>"Jerry Seinfeld", "vehicle"=>"Ford Taurus"}
        user2_return = {"id"=>"2", "name"=>"Kramer", "vehicle"=>"Lincoln Continental"}

        expect(data).to eq([user1_return, user2_return])
      end
    end

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
  end
end
