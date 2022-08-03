class Api::V1::GardensController < ApplicationController
  # GET /users/user_id/gardens
  def index
    user = User.find(params[:user_id])
    gardens = user.gardens

    render json: GardenSerializer.new(gardens)
  end

  # GET /gardens/1
  def show
    if Garden.exists?(params[:id]) && Garden.find(params[:id]).user.id == params[:user_id].to_i
      render json: GardenSerializer.new(Garden.find(params[:id]))
    else
      render status: 404
    end
  end

  # POST /gardens
  def create
    @garden = Garden.new(garden_params)

    if @garden.save

      render json: GardenSerializer.new(@garden), status: :created
    else
      render status: 404
    end
  end

  # PATCH/PUT /gardens/1
  def update
    if Garden.exists?(params[:id])
      garden = Garden.update(params[:id], garden_params)
      if garden.save
        render json: GardenSerializer.new(garden)
      else
        render status: 404
      end
    else
      render status: 404
    end
  end

  # DELETE /gardens/1
  def destroy
    if Garden.exists?(params[:id])
      Garden.destroy(params[:id])
    else
      render status: 404
    end
  end

  def garden_params
    JSON.parse(params['_json'], symbolize_names: true)
  end
end
