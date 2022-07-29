class PlantSerializer
  include JSONAPI::Serializer
  attributes :name,
             :plant_id,
             :date_planted,
             :moon_phase,
             :date_matured,
             :bounty_amount,
             :pruning_behaviors,
             :notes,
             :garden_id
end
