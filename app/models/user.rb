class User < ApplicationRecord
  has_many :comments, dependent: :delete_all
  has_many :favorites, dependent: :delete_all
  has_many :trails, through: :favorites

  validates_presence_of :name, :vehicle
end
