# frozen_string_literal: true

class GCondutorSerializer < ActiveModel::Serializer
  attributes :id, :nome, :cnh_numero, :telefone, :email, :created_at, :updated_at
end
