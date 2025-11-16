class GCentroCusto < ApplicationRecord
  self.table_name = "g_centros_custos"

  belongs_to :g_tipo_centro_custo, class_name: "GTipoCentroCusto", foreign_key: "g_tipo_centro_custo_id"
  belongs_to :a_unidade,           class_name: "AUnidade",         foreign_key: "a_unidade_id"
end
