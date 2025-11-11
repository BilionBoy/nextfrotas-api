# frozen_string_literal: true

class CRequisicaoCombustivelSerializer < ActiveModel::Serializer
  attributes :id, :data_emissao, :km_ultimo, :km_atual, :motivo, :destino, :itinerario, :preco_unitario, :quantidade_litros,
   :valor_total, :completar_tanque, :created_at, :updated_at, :voucher_codigo, :voucher_status, :voucher_validade, :voucher_validado_em

  belongs_to :posto, serializer: CPostoSerializer, key: :c_posto
  belongs_to :veiculo, serializer: GVeiculoSerializer, key: :g_veiculo
  belongs_to :condutor, serializer: GCondutorSerializer, key: :g_condutor
  belongs_to :centro_custo, serializer: GCentroCustoSerializer, key: :g_centro_custo
  belongs_to :tipo_combustivel, serializer: CTipoCombustivelSerializer, key: :c_tipo_combustivel
  belongs_to :status, serializer: OStatusSerializer, key: :o_status

  attribute :valor_total_formatado do
    "R$ #{'%.2f' % object.valor_total}".tr(".", ",") if object.valor_total
  end

  attribute :preco_unitario_formatado do
    "R$ #{'%.2f' % object.preco_unitario}".tr(".", ",") if object.preco_unitario
  end

  attribute :quantidade_litros_formatado do
    "#{'%.2f' % object.quantidade_litros} L" if object.quantidade_litros
  end
end
