class Garden < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :cardinal_direction
  validates_presence_of :notes
  belongs_to :user

  enum cardinal_direction: ['North', 'South', 'East', 'West']
end
