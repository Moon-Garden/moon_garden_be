class Api::V1::UsersController < ApplicationController
  def index
    render json: 'HI'
  end

  def find_or_create_user
    google_data = JSON.parse(params['_json'], symbolize_names: true)

    @user = User.find_or_create_by(email: google_data[:email]) do |user|
      user.name = google_data[:name]
      user.email = google_data[:email]
      user.image = google_data[:image]
    end

    render json: UserSerializer.new(@user)
  end

  def show
    if User.exists?(params[:id])
      render json: UserSerializer.new(User.find(params[:id]))
    else
      render status: 404
    end
  end
end
