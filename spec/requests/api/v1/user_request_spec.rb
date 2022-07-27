require 'rails_helper'

RSpec.describe 'Users API' do
  describe 'happy path' do
    it 'creates a user' do
      user_params = {
        name: 'Saba',
        email: 'saba@saba.com',
        image: 'thisisanimage'
      }
      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v1/users', headers: headers, params: JSON.generate(user: user_params)

      expect(response).to be_successful

      parsed_body = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_body).to have_key(:data)
      expect(parsed_body[:data]).to be_a Hash

      user = parsed_body[:data]

      expect(user).to have_key :id
      expect(user[:id]).to be_a String
      expect(user).to have_key :type
      expect(user[:type]).to eq('user')

      expect(user).to have_key :attributes

      expect(user[:attributes]).to have_key :name
      expect(user[:attributes][:name]).to be_a String
      expect(user[:attributes][:name]).to eq(user_params[:name])

      expect(user[:attributes]).to have_key :email
      expect(user[:attributes][:email]).to be_a String
      expect(user[:attributes][:email]).to eq(user_params[:email])

      expect(user[:attributes]).to have_key :image
      expect(user[:attributes][:image]).to be_a String
      expect(user[:attributes][:image]).to eq(user_params[:image])

      expect(user).to_not have_key :created_at
      expect(user).to_not have_key :updated_at
    end

    it 'finds a user' do
      user1 = create(:user)

      headers = { 'CONTENT_TYPE' => 'application/json' }

      get '/api/v1/user', headers: headers, params: { email: user1.email }

      parsed_body = JSON.parse(response.body, symbolize_names: true)

      user = parsed_body[:data]

      expect(user).to have_key :id
      expect(user[:id]).to be_a String
      expect(user).to have_key :type
      expect(user[:type]).to eq('user')

      expect(user).to have_key :attributes

      expect(user[:attributes]).to have_key :name
      expect(user[:attributes][:name]).to be_a String
      expect(user[:attributes][:name]).to eq(user1[:name])

      expect(user[:attributes]).to have_key :email
      expect(user[:attributes][:email]).to be_a String
      expect(user[:attributes][:email]).to eq(user1[:email])

      expect(user[:attributes]).to have_key :image
      expect(user[:attributes][:image]).to be_a String
      expect(user[:attributes][:image]).to eq(user1[:image])

      expect(user).to_not have_key :created_at
      expect(user).to_not have_key :updated_at
    end
  end
end
