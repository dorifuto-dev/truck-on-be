module Types
  class TrailTagType < Types::BaseObject
    field :id, ID, null: false
    field :trail_id, Integer, null: true
    field :tag_id, Integer, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
