class User < ApplicationRecord
  def self.google_user(params)
    google_data = JSON.parse(params['_json'], symbolize_names: true)

    user = User.find_or_create_by(email: google_data[:email]) do |user|
      user.name = google_data[:name]
      user.email = google_data[:email]
      user.image = google_data[:image]
    end
  end
end
