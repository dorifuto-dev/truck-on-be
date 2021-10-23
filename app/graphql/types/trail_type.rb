module Types
  class TrailType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: true
    field :latitude, Float, null: true
    field :longitude, Float, null: true
    field :elevation_gain, Integer, null: true
    field :description, String, null: true
    field :difficulty, String, null: true
    field :route_type, String, null: true
    field :traffic, String, null: true
    field :nearest_city, String, null: true
    field :distance, Integer, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :tags, [Types::TagType], null: true
    field :temp, Float, null: true
    field :conditions, String, null: true
    field :comments, [Types::CommentType], null: true
    field :comment_count, Integer, null: true

    def temp
      weather = WeatherFacade.weather_info(object.latitude, object.longitude)
      weather.temp
    end

    def conditions
      weather = WeatherFacade.weather_info(object.latitude, object.longitude)
      weather.conditions
    end

    def comments
      object.comments
    end

    def comment_count
      object.comments.count
    end
  end
end
