class GardenSerializer
  include JSONAPI::Serializer
  attributes :name, :cardinal_direction, :notes
  belongs_to :user
end
