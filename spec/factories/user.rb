FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    image { 'https://upload.wikimedia.org/wikipedia/commons/1/15/EasternGraySquirrel_GAm.jpg' }
  end
end
