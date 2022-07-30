class Api::V1::PlantsController < ApplicationController
  before_action :set_plant, only: %i[show update destroy]

  # GET /plants
  def index
    @plants = Plant.all

    render json: PlantSerializer.new(@plants)
  end

  # GET /plants/1
  def show
    render json: PlantSerializer.new(@plant)
  end

  # POST /plants
  def create
    @plant = Plant.new({ name: plant_params[:name],
                         plant_id: plant_params[:plant_id],
                         garden_id: params[:garden_id] })

    if @plant.save
      render json: PlantSerializer.new(@plant)
    else
      render json: @plant.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /plants/1
  def update
    if @plant.update(plant_params)
      render json: PlantSerializer.new(@plant)
    else
      render json: @plant.errors, status: :unprocessable_entity
    end
  end

  # DELETE /plants/1
  def destroy
    @plant.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_plant
    @plant = Plant.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def plant_params
    JSON.parse(params['_json'], symbolize_names: true)
  end
end
