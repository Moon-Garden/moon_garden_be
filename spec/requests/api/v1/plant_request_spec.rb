require 'rails_helper'

RSpec.describe 'Plants API' do
  describe 'happy path' do
    let!(:user_1) { create :user }
    let!(:user_2) { create :user }
    let!(:gardens) { create_list :garden, 2, { user_id: user_1.id } }
    let!(:plants) { create_list(:plant, 4, garden_id: gardens[0].id) }

    it 'returns all plants' do
      get "/api/v1/users/#{user_1.id}/gardens/#{gardens[0].id}/plants"

      expect(response).to be_successful

      rb = JSON.parse(response.body, symbolize_names: true)
      plants = rb[:data]

      expect(plants).to be_an Array
      expect(plants.count).to eq(4)

      plants.each do |plant|
        expect(plant).to have_key(:id)
        expect(plant[:id]).to be_an(String)

        expect(plant[:type]).to be_a(String)

        expect(plant).to have_key(:attributes)
        expect(plant[:attributes]).to be_a(Hash)

        expect(plant[:attributes][:name]).to be_a(String)
      end
    end

    it 'can find a specific plant by id' do
      get "/api/v1/users/#{user_1.id}/gardens/#{gardens[0].id}/plants/#{plants[0].id}"

      expect(response).to be_successful

      rb = JSON.parse(response.body, symbolize_names: true)
      plant = rb[:data]

      expect(plant).to have_key(:id)
      expect(plant[:id]).to be_an(String)

      expect(plant[:type]).to be_a(String)

      expect(plant).to have_key(:attributes)
      expect(plant[:attributes]).to be_a(Hash)

      expect(plant[:attributes][:name]).to be_a(String)
    end

    it 'can create a new plant' do
      plant_api_info = "{\"name\":\"Basil\",\"plant_id\":\"awehfh9832y5r334hi\"}"

      headers = { 'CONTENT_TYPE' => 'application/json' }
      post "/api/v1/users/#{user_1.id}/gardens/#{gardens[0].id}/plants", headers: headers,
                                                                         params: JSON.generate(plant_api_info)

      created_plant = Plant.last

      expect(response).to be_successful
      expect(created_plant.name).to eq('Basil')
      expect(created_plant.plant_id).to eq('awehfh9832y5r334hi')
    end

    it 'can update an existing plant' do
      id = plants[0].id
      previous_name = plants[0].name
      plant_params = '{"name":"Dingleberry"}'
      headers = { 'CONTENT_TYPE' => 'application/json' }

      patch "/api/v1/users/#{user_1.id}/gardens/#{gardens[0].id}/plants/#{id}", headers: headers,
                                                                                params: JSON.generate(plant_params)
      plant = Plant.find_by(id: id)
      expect(response).to be_successful
      expect(plant.name).to_not eq(previous_name)
      expect(plant.name).to eq('Dingleberry')
    end

    it 'can destroy an plant' do
      plant = create(:plant, garden_id: gardens[0].id)

      expect(Plant.count).to eq(5)

      delete "/api/v1/users/#{user_1.id}/gardens/#{gardens[0].id}/plants/#{plant.id}"

      expect(response).to be_successful
      expect(Plant.count).to eq(4)
      expect { Plant.find(plant.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
