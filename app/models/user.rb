class User < ApplicationRecord
  has_many :comments
  has_many :favorites
  has_many :trails, through: :favorites

  validates_presence_of :name, :vehicle
end
