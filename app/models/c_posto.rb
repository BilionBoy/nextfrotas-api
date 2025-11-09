class CPosto < ApplicationRecord
  self.table_name = "c_postos"

  belongs_to :g_municipio, optional: true
  belongs_to :g_estado, optional: true
  belongs_to :a_status, optional: true

  # Se quiser carregar combustíveis do posto
  has_many :c_postos_combustiveis, foreign_key: "c_posto_id"
end
