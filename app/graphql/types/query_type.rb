module Types
  class QueryType < Types::BaseObject
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :users, [Types::UserType], null: false
    field :trails, [Types::TrailType], null: false
    field :tags, [Types::TagType], null: false

    def users
      User.all
    end

    def trails
      Trail.all
    end

    def tags
      Tag.all
    end
  end
end
