module Types
  class QueryType < Types::BaseObject
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :users, [Types::UserType], null: false
    field :trails, [Types::TrailType], null: false
    field :tags, [Types::TagType], null: false

    field :trail, Types::TrailType, null: false do
      argument :id, ID, required: true
      # resolve ->(_obj, args, _ctx) { Trails.find_by!(id: args[:id]) }
    end

    field :user, Types::UserType, null: false do
      argument :id, ID, required: true
    end

    field :tag, Types::TagType, null: false do
      argument :id, ID, required: true
    end

    def users
      User.all
    end

    def trails
      Trail.all
    end

    def tags
      Tag.all
    end

    def trail(id:)
      Trail.find(id)
    end

    def user(id:)
      User.find(id)
    end

    def tag(id:)
      Tag.find(id)
    end
  end
end
