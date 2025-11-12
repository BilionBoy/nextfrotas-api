class GVeiculoSerializer < ActiveModel::Serializer
  attributes :id, :placa, :chassi, :renavam, :modelo, :ano, :marca, :cor, :km_atual, :created_at, :updated_at

  belongs_to :a_status,       serializer: AStatusSerializer
  belongs_to :g_tipo_veiculo, serializer: GTipoVeiculoSerializer
  belongs_to :a_unidade,      serializer: AUnidadeSerializer
  belongs_to :g_centro_custo, serializer: GCentroCustoSerializer
end
