module Types
  class TrailType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: true
    field :latitude, Float, null: true
    field :longitude, Float, null: true
    field :elevation_gain, Integer, null: true
    field :description, String, null: true
    field :difficulty, Integer, null: true
    field :route_type, Integer, null: true
    field :traffic, Integer, null: true
    field :nearest_city, String, null: true
    field :distance, Integer, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
