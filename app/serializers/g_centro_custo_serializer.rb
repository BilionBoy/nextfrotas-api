# frozen_string_literal: true

class GCentroCustoSerializer < ActiveModel::Serializer
  attributes :id, :nome, :codigo_dotacao, :created_at, :updated_at
end
