require 'rails_helper'

RSpec.describe 'Garden API' do
  describe 'happy path' do
    let!(:user) {create :user}
    # let!(:gardens) { create_list :garden, 3, { user_id: user.id } }

    it 'returns all of a users gardens' do
      gardens = create_list(:garden, 3, { user_id: user.id })
      get "/api/v1/users/#{user.id}/gardens"

      expect(response).to be_successful
      rb = JSON.parse(response.body, symbolize_names: true)
      users_gardens = rb[:data]

      expect(users_gardens).to be_an Array
      expect(users_gardens.count).to eq(3)

      users_gardens.each do |gard|
        expect(gard).to have_key(:id)
        expect(gard[:id]).to be_an(String)

        expect(gard[:type]).to be_a(String)

        expect(gard).to have_key(:attributes)
        expect(gard[:attributes]).to be_a(Hash)

        expect(gard[:attributes][:name]).to be_a(String)
      end
    end



    it 'creates a garden' do
      #user = create(:user)
      garden_json = 
        {
          "user_id": user.id,
          "name": "value1",
          "notes": "value2",
          "cardinal_direction": 1
        }
      headers = { 'CONTENT_TYPE' => 'application/json' }

      post "/api/v1/users/#{user.id}/gardens", headers: headers, params: JSON.generate(garden_json)

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
      #user = create(:user)
      garden = create(:garden, user_id: user.id)
      
      get "/api/v1/users/#{user.id}/gardens/#{garden.id}"
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

    it 'updates garden' do 
      #user = create(:user)
      garden = create(:garden, user_id: user.id)
      garden_json = {
        name: 'Garden of Eden',
        cardinal_direction: 'West',
        notes: 'These are notes.'
      }
      headers = {"CONTENT_TYPE" => "application/json"}
      
      patch "/api/v1/users/#{user.id}/gardens/#{garden.id}", headers: headers, params: JSON.generate(garden_json)
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
      expect(garden[:attributes][:name]).to eq('Garden of Eden')

      expect(garden[:attributes]).to have_key :cardinal_direction
      expect(garden[:attributes][:cardinal_direction]).to be_a String
      expect(garden[:attributes][:cardinal_direction]).to eq('West')

      expect(garden[:attributes]).to have_key :notes
      expect(garden[:attributes][:notes]).to be_a String
      expect(garden[:attributes][:notes]).to eq('These are notes.')

      expect(garden).to_not have_key :created_at
      expect(garden).to_not have_key :updated_at
    end

    it 'destroys a single item' do
      #user = create(:user)
      garden = create(:garden, user_id: user.id)

      expect{ delete "/api/v1/users/#{user.id}/gardens/#{garden.id}" }.to change(Garden, :count).by(-1)
      expect{Garden.find(garden.id)}.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe 'sad path' do
    let!(:user) {create :user}

    it 'response will be unsuccessful if attribute is missing' do
      # user = create(:user)
      garden_json = 
        {
          "user_id": user.id,
          "name": "value1",
          "notes": "value2"
        }
      headers = { 'CONTENT_TYPE' => 'application/json' }

      post "/api/v1/users/#{user.id}/gardens", headers: headers, params: JSON.generate(garden_json)

      expect(response).to_not be_successful
    end

    it 'response will be unsuccessful if item does not exist' do
      get "/api/v1/users/#{user.id}/gardens/999999999"

      expect(response).to_not be_successful
    end

    it 'response will be unsuccessful if parameter is invalid' do
      # user = create(:user)
      garden = create(:garden, user_id: user.id)
      garden_json = {
        user_id: 123123123123123123123123123
                    }
      headers = {"CONTENT_TYPE" => "application/json"}

      patch "/api/v1/users/#{user.id}/gardens/#{garden.id}", headers: headers, params: JSON.generate(garden_json)
      expect(response).to_not be_successful
    end

    it 'response will be unsuccessful if garden does not exist' do
      delete "/api/v1/users/#{user.id}/gardens/999999999"
      expect(response).to_not be_successful
    end

    it 'response will be unsuccessful if garden does not exist' do
      garden_json = {
        name: 'Garden of Eden',
        cardinal_direction: 'West',
        notes: 'These are notes.'
      }
      headers = {"CONTENT_TYPE" => "application/json"}
      
      patch "/api/v1/users/#{user.id}/gardens/1", headers: headers, params: JSON.generate(garden_json)
      expect(response).to_not be_successful
    end
  end
end