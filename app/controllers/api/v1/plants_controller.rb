class Api::V1::PlantsController < ApplicationController
  before_action :set_plant, only: %i[show update destroy]

  # GET /plants
  def index
    garden = Garden.find(params[:garden_id])
    render json: PlantSerializer.new(garden.plants)
  end

  # GET /plants/1
  def show
    render json: PlantSerializer.new(@plant)
  end

  # POST /plants
  def create
    @plant = Plant.new(plant_params)

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
    a = JSON.parse(params['_json'], symbolize_names: true)
    a.delete(:user_id)
    a

    # .permit(:name, :plant_id, :date_planted, :moon_phase,
    # :date_matured, :bounty_amount, :pruning_behaviors, :notes, :garden_id)
  end
end
