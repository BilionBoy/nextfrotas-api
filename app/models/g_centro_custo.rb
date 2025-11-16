class GCentroCusto < ApplicationRecord
  self.table_name = "g_centros_custos"

  belongs_to :g_tipo_centro_custo
end
