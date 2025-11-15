# frozen_string_literal: true

class FEmpresaFornecedoraSerializer < ActiveModel::Serializer
  attributes :id, :nome_fantasia, :cnjp, :endereco, :created_at, :updated_at
end
