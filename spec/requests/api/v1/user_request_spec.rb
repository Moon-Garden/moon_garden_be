require 'rails_helper'

RSpec.describe 'Users API' do
  describe 'happy path' do
    describe 'google Oauth' do
      it 'creates a user' do
        google_info = '{"name":"Jennifer Halloran","email":"jenniferlhalloran@gmail.com","unverified_email":"jenniferlhalloran@gmail.com","email_verified":true,"first_name":"Jennifer","last_name":"Halloran","image":"https://lh3.googleusercontent.com/a-/AFdZucr_zffBdhJaydFkdXeeHkhe2BzmVNKGIE-Ozwvh=s96-c"}'
        headers = { 'CONTENT_TYPE' => 'application/json' }

        post '/api/v1/find_or_create_user', headers: headers, params: JSON.generate(google_info)

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

        expect(user[:attributes]).to have_key :email
        expect(user[:attributes][:email]).to be_a String

        expect(user[:attributes]).to have_key :image
        expect(user[:attributes][:image]).to be_a String

        expect(user).to_not have_key :created_at
        expect(user).to_not have_key :updated_at
      end

      it 'finds a user if exists' do
        jen = create(:user, email: 'jenniferlhalloran@gmail.com', name: 'Jennifer Halloran', image: 'https://lh3.googleusercontent.com/a-/AFdZucr_zffBdhJaydFkdXeeHkhe2BzmVNKGIE-Ozwvh=s96-c')

        google_info = '{"name":"Jennifer Halloran","email":"jenniferlhalloran@gmail.com","unverified_email":"jenniferlhalloran@gmail.com","email_verified":true,"first_name":"Jennifer","last_name":"Halloran","image":"https://lh3.googleusercontent.com/a-/AFdZucr_zffBdhJaydFkdXeeHkhe2BzmVNKGIE-Ozwvh=s96-c"}'
        headers = { 'CONTENT_TYPE' => 'application/json' }

        post '/api/v1/find_or_create_user', headers: headers, params: JSON.generate(google_info)

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

        expect(user[:id].to_i).to eq(jen.id)

        expect(user[:attributes]).to have_key :name
        expect(user[:attributes][:name]).to be_a String

        expect(user[:attributes]).to have_key :email
        expect(user[:attributes][:email]).to be_a String

        expect(user[:attributes]).to have_key :image
        expect(user[:attributes][:image]).to be_a String

        expect(user).to_not have_key :created_at
        expect(user).to_not have_key :updated_at
      end
    end

    it '#show' do
      user1 = create(:user)
      user_id = user1.id

      get "/api/v1/users/#{user_id}"

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

      expect(user[:id].to_i).to eq(user1.id)

      expect(user[:attributes]).to have_key :name
      expect(user[:attributes][:name]).to be_a String

      expect(user[:attributes]).to have_key :email
      expect(user[:attributes][:email]).to be_a String

      expect(user[:attributes]).to have_key :image
      expect(user[:attributes][:image]).to be_a String

      expect(user).to_not have_key :created_at
      expect(user).to_not have_key :updated_at
    end
  end
  describe 'sad path' do
    it '#show' do
      get '/api/v1/users/1'

      expect(response).to_not be_successful
    end
  end
end
