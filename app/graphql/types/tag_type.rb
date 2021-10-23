module Types
  class TagType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :trails, [Types::TrailType], null: true

    def trails
      object.trails
    end
  end
end
