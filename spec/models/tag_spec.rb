require 'rails_helper'

RSpec.describe Tag do
  describe 'associations' do
    it { should have_many(:trail_tags) }
    it { should have_many(:trails).through(:trail_tags) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end
end
