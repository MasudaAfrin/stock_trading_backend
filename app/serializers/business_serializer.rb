class BusinessSerializer < ActiveModel::Serializer
  attributes :id, :name, :shares_available, :created_at
end
