class Tag < ApplicationRecord
  has_many :trail_tags, dependent: :delete_all
  has_many :trails, through: :trail_tags

  validates_presence_of :name
end
