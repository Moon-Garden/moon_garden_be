require 'rails_helper'

RSpec.describe 'Users API' do
  describe 'happy path' do
    it 'creates a garden' do
      user = create(:user)
      garden_json = 
        {
          "user_id": user.id,
          "name": "value1",
          "notes": "value2",
          "cardinal_direction": 1
        }
      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v1/gardens', headers: headers, params: JSON.generate(garden_json)

      expect(response).to be_successful

      parsed_body = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_body).to have_key(:data)
      expect(parsed_body[:data]).to be_a Hash

      garden = parsed_body[:data]

      expect(garden).to have_key :id
      expect(garden[:id]).to be_a String
      expect(garden).to have_key :type
      expect(garden[:type]).to eq('garden')

      expect(garden).to have_key :attributes

      expect(garden[:attributes]).to have_key :name
      expect(garden[:attributes][:name]).to be_a String

      expect(garden[:attributes]).to have_key :cardinal_direction
      expect(garden[:attributes][:cardinal_direction]).to be_a String

      expect(garden[:attributes]).to have_key :notes
      expect(garden[:attributes][:notes]).to be_a String

      expect(garden).to_not have_key :created_at
      expect(garden).to_not have_key :updated_at
    end

    it 'finds a garden' do
      user = create(:user)
      garden = create(:garden, user_id: user.id)
      
      get "/api/v1/gardens/#{garden.id}"
      expect(response).to be_successful

      parsed_body = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_body).to have_key(:data)
      expect(parsed_body[:data]).to be_a Hash

      garden = parsed_body[:data]

      expect(garden).to have_key :id
      expect(garden[:id]).to be_a String
      expect(garden).to have_key :type
      expect(garden[:type]).to eq('garden')

      expect(garden).to have_key :attributes

      expect(garden[:attributes]).to have_key :name
      expect(garden[:attributes][:name]).to be_a String

      expect(garden[:attributes]).to have_key :cardinal_direction
      expect(garden[:attributes][:cardinal_direction]).to be_a String

      expect(garden[:attributes]).to have_key :notes
      expect(garden[:attributes][:notes]).to be_a String

      expect(garden).to_not have_key :created_at
      expect(garden).to_not have_key :updated_at
    end
  end
end