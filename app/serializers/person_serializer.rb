class PersonSerializer < ActiveModel::Serializer
  attributes :id, :name, :bio, :birthday
end
