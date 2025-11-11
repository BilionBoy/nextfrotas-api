# frozen_string_literal: true

class CPostoSerializer < ActiveModel::Serializer
  attributes :id,
             :nome_fantasia,
             :cnpj,
             :endereco,
             :created_at,
             :updated_at
end
