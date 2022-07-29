require 'rails_helper'

RSpec.describe Garden, type: :model do
  describe 'relationships' do
    it { should belong_to :user }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:cardinal_direction) }
    it { should validate_presence_of(:notes) }
  end

end