# frozen_string_literal: true

class OStatusSerializer < ActiveModel::Serializer
  attributes :id, :descricao, :created_at, :updated_at
end
