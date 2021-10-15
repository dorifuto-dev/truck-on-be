require 'rails_helper'

RSpec.describe Comment do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:trail) }
  end
end
