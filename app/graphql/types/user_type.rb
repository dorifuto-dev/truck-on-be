module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: true
    field :vehicle, String, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :favorites, [Types::TrailType], null: true
    field :comments, [Types::CommentType], null: true
    field :comment_count, Integer, null: true

    def favorites
      object.trails
    end

    def comments
      object.comments
    end

    def comment_count
      object.comments.count
    end
  end
end
