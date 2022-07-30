FactoryBot.define do
  factory :garden do
    name { Faker::Fantasy::Tolkien.location }
    cardinal_direction { Faker::Number.within(range: 0..3) }
    notes { Faker::Lorem.sentences }
  end
end