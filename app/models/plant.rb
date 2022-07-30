class Plant < ApplicationRecord
  belongs_to :garden

  validates_presence_of :name
  validates_presence_of :plant_id
  validates_presence_of :garden_id
end
