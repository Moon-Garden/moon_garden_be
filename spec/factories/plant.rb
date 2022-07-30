FactoryBot.define do
  factory :plant do
    name {Faker::Artist.name}
    plant_id {Faker::Number.number(digits: 2)}
    date_planted {Faker::Date.backward(days: 90)}
    moon_phase {Faker::Lorem.sentence}
    date_matured {Faker::Date.backward(days: 10)}
    bounty_amount {Faker::Number.number(digits: 2)}
    pruning_behaviors {Faker::Lorem.sentence}
    notes {Faker::Lorem.sentence}
  end
end