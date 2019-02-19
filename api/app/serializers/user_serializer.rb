class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :callback_link
end
