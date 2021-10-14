require 'rails_helper'

RSpec.describe Trail do
  describe 'associations' do
    it { should have_many(:favorites) }
    it { should have_many(:users).through(:favorites) }
    it { should have_many(:comments) }
    it { should have_many(:trail_tags) }
    it { should have_many(:tags).through(:trail_tags) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:latitude) }
    it { should validate_presence_of(:longitude) }
    it { should validate_presence_of(:elevation_gain) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:difficulty) }
    it { should validate_presence_of(:type) }
    it { should validate_presence_of(:traffic) }
    it { should validate_presence_of(:nearest_city) }
    it { should validate_presence_of(:distance) }

    it { should validate_numericality_of(:latitude) }
    it { should validate_numericality_of(:longitude) }
    it { should validate_numericality_of(:elevation_gain) }
    it { should validate_numericality_of(:distance) }

    it { should define_enum_for(:difficulty).with_values(['Novice', 'Intermediate', 'Expert']) }
    it { should define_enum_for(:type).with_values(['Loop', 'Out and Back', 'Point to Point']) }
    it { should define_enum_for(:traffic).with_values(['Light', 'Moderate', 'Heavy']) }
  end
end
