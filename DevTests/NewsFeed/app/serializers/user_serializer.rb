class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :avatar, :latitude, :longitude
end
