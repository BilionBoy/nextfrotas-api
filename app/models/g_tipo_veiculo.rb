class GTipoVeiculo < ApplicationRecord
  self.table_name = "g_tipos_veiculos"
  has_many :g_veiculos


  validates :descricao, presence: true
end
