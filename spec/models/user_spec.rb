require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'relationships' do
    it { should have_many :gardens }
  end

  describe 'class methods' do
    it '#google_user' do
      params = { '_json' => '{"name":"Jennifer Halloran","email":"jenniferlhalloran@gmail.com","unverified_email":"jenniferlhalloran@gmail.com","email_verified":true,"first_name":"Jennifer","last_name":"Halloran","image":"https://lh3.googleusercontent.com/a-/AFdZucr_zffBdhJaydFkdXeeHkhe2BzmVNKGIE-Ozwvh=s96-c"}' }

      user = User.google_user(params)

      expect(user[:id]).to be_a Integer
      expect(user[:name]).to be_a String
      expect(user[:email]).to be_a String
      expect(user[:image]).to be_a String
    end
  end
end
