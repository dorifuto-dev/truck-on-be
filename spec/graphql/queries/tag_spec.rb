require 'rails_helper'

module Queries
  RSpec.describe Tag, type: :request do
    before(:each) do
      tag = create(:tag, id: 1, name: 'Camping' )
      tag2 = create(:tag, id: 2, name: 'Snowmobile'  )
      trail = create(:trail, name: 'faketrail')
      trail_tag = TrailTag.create(tag: tag, trail: trail)

    end
    describe 'tags' do
      it 'returns all tags' do
        def query
          <<~GQL
            query {
              tags {
                id
                name
              }
            }
          GQL
        end

        post '/graphql', params: { query: query }

        json = JSON.parse(response.body)
        data = json['data']['tags']
        tag1_return = { "id"=>"1",
                        "name"=>"Camping"
                      }
        tag2_return = { "id"=>"2",
                        "name"=>"Snowmobile"
                      }

        expect(data).to eq([tag1_return, tag2_return])
      end

      it 'returns only particular data about a tag' do
        def query
          <<~GQL
            query {
              tags {
                id
              }
            }
          GQL
        end

        post '/graphql', params: { query: query }

        json = JSON.parse(response.body)
        data = json['data']['tags']
        tag1_return = { "id"=>"1" }

        tag2_return = { "id"=>"2" }

        expect(data).to eq([tag1_return, tag2_return])
      end
    end

    describe 'tag' do

      it 'returns only particular tag if requested' do
        def query
          <<~GQL
            query {
              tag(id: 1) {
                name
              }
            }
          GQL
        end

        post '/graphql', params: { query: query }

        json = JSON.parse(response.body)
        data = json['data']['tag']
        tag_return = {
                        "name"=>"Camping"
                      }

        expect(data).to eq(tag_return)
      end

      it 'returns trails associated to a particular tag if requested' do
        def query
          <<~GQL
            query {
              tag(id: 1) {
                name
                trails {
                  name
                }
              }
            }
          GQL
        end

        post '/graphql', params: { query: query }

        json = JSON.parse(response.body)
        data = json['data']['tag']
        tag_and_trail_return = {"name"=>"Camping", "trails"=>[{"name"=>"faketrail"}]}

        expect(data).to eq(tag_and_trail_return)
      end

      it 'returns empty array of trails if none are associated' do
        def query
          <<~GQL
            query {
              tag(id: 2) {
                name
                trails {
                  name
                }
              }
            }
          GQL
        end

        post '/graphql', params: { query: query }

        json = JSON.parse(response.body)
        data = json['data']['tag']
        tag_and_trail_return = {"name"=>"Snowmobile", "trails"=>[]}

        expect(data).to eq(tag_and_trail_return)
      end
    end
  end
end
