# app/models/g_veiculo.rb
class GVeiculo < ApplicationRecord
  self.table_name = "g_veiculos"

  belongs_to :a_status, class_name: "AStatus"
  belongs_to :g_tipo_veiculo
  belongs_to :a_unidade
  belongs_to :g_centro_custo

  before_create :definir_status_padrao

  private

  def definir_status_padrao
    self.a_status_id ||= OStatus.find_by(descricao: "Ativo")&.id || 1
  end
end
