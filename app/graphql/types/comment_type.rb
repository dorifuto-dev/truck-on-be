module Types
  class CommentType < Types::BaseObject
    field :id, ID, null: false
    field :trail_id, Integer, null: true
    field :user_id, Integer, null: true
    field :content, String, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
