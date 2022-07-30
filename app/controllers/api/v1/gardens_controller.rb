class Api::V1::GardensController < ApplicationController
  before_action :set_garden, only: [:show, :update, :destroy]

  # GET /gardens
  # def index
  #   @gardens = Garden.all

  #   render json: @gardens
  # end

  # GET /gardens/1
  def show
    render json: GardenSerializer.new(@garden)
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_garden
      @garden = Garden.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def garden_params
      params.require(:garden).permit(:name, :cardinal_direction, :notes, :user_id)
    end
end
