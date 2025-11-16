class GTipoCentroCustoSerializer < ActiveModel::Serializer
  attributes :id, :descricao

  has_many :g_centros_custos
end
