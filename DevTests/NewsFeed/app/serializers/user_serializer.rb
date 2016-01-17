class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :latitude, :longitude
end
