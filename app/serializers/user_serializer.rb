class UserSerializer
  include JSONAPI::Serializer
  attributes :name, :email, :image
end
