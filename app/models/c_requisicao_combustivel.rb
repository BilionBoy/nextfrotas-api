# app/models/c_requisicao_combustivel.rb
class CRequisicaoCombustivel < ApplicationRecord
  self.table_name = "c_requisicoes_combustiveis"

  belongs_to :posto,            class_name: "CPosto",           foreign_key: "c_posto_id",        optional: true
  belongs_to :veiculo,          class_name: "GVeiculo",         foreign_key: "g_veiculo_id",      optional: true
  belongs_to :condutor,         class_name: "GCondutor",        foreign_key: "g_condutor_id",     optional: true
  belongs_to :centro_custo,     class_name: "GCentroCusto",     foreign_key: "g_centro_custo_id", optional: true
  belongs_to :tipo_combustivel, class_name: "CTipoCombustivel", foreign_key: "c_tipo_combustivel_id", optional: true
  belongs_to :status,           class_name: "OStatus",          foreign_key: "o_status_id", optional: true

end
