require 'rails_helper'

RSpec.describe TrailTag do
  describe 'associations' do
    it { should belong_to(:tag) }
    it { should belong_to(:trail) }
  end
end
