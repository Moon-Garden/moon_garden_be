FactoryBot.define do
  factory :plant do
    name {Faker::Seinfeld.character}
    plant_id {Faker::Number.number(digits: 2)}
    date_planted {Faker::Date.backward(days: 90)}
    moon_phase {Faker::Seinfeld.quote}
    date_matured {Faker::Date.backward(days: 10)}
    bounty_amount {Faker::Number.number(digits: 2)}
    pruning_behaviors {Faker::Seinfeld.quote}
    notes {Faker::Seinfeld.quote}
    garden_id {1}
  end
end