require 'rails_helper'

RSpec.describe User do
  describe 'associations' do
    it { should have_many(:favorites) }
    it { should have_many(:trails).through(:favorites) }
    it { should have_many(:comments) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:vehicle) }
  end
end
