require 'rails_helper'

RSpec.describe Favorite do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:trail) }
  end
end
