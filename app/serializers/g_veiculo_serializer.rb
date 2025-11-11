# frozen_string_literal: true

class GVeiculoSerializer < ActiveModel::Serializer
  attributes :id, :placa, :modelo, :marca, :ano, :cor, :created_at, :updated_at
end
