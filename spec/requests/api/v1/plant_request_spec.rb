require 'rails_helper'

RSpec.describe 'Plants API' do
  describe 'happy path' do
    it 'returns a plant' do
      let!(:plant) {create :plant}
      require "pry"; binding.pry
    end
  end
end