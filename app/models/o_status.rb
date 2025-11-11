class OStatus < ApplicationRecord
  self.table_name = "o_status" 

  has_many :requisicoes_combustiveis, class_name: "CRequisicaoCombustivel", foreign_key: "o_status_id", dependent: :nullify
end
