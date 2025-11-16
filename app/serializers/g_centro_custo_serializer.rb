# frozen_string_literal: true

class GCentroCustoSerializer < ActiveModel::Serializer
  attributes :id, :nome, :codigo_dotacao, :valor_inicial, :saldo_atual

  belongs_to :g_tipo_centro_custo, serializer: GTipoCentroCustoSerializer
end
