class Api::V1::UsersController < ApplicationController
  def find_or_create_user
    render json: UserSerializer.new(User.google_user(params))
  end

  def show
    if User.exists?(params[:id])
      render json: UserSerializer.new(User.find(params[:id]))
    else
      render status: 404
    end
  end
end
