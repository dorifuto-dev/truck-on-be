class Trail < ApplicationRecord
  has_many :favorites
  has_many :users, through: :favorites
  has_many :trail_tags
  has_many :tags, through: :trail_tags
  has_many :comments

  enum difficulty: { 'Novice' => 0, 'Intermediate' => 1, 'Expert' => 2 }
  enum route_type: { 'Loop' => 0, 'Out and Back' => 1, 'Point to Point' => 2 }
  enum traffic: { 'Light' => 0, 'Moderate' => 1, 'Heavy' => 2 }

  validates :name, presence: true
  validates :latitude, presence: true, numericality: true
  validates :longitude, presence: true, numericality: true
  validates :elevation_gain, presence: true, numericality: true
  validates :description, presence: true
  validates :difficulty, presence: true, numericality: { only_integer: true }
  validates :route_type, presence: true, numericality: { only_integer: true }
  validates :traffic, presence: true, numericality: { only_integer: true }
  validates :nearest_city, presence: true
  validates :distance, presence: true, numericality: true
end
