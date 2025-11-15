# app/models/c_requisicao_combustivel.rb
class CRequisicaoCombustivel < ApplicationRecord
  self.table_name = "c_requisicoes_combustiveis"

  belongs_to :posto,                 class_name: "CPosto",                 foreign_key: "c_posto_id",                  optional: true
  belongs_to :veiculo,               class_name: "GVeiculo",               foreign_key: "g_veiculo_id",                optional: true
  belongs_to :condutor,              class_name: "GCondutor",              foreign_key: "g_condutor_id",               optional: true
  belongs_to :centro_custo,          class_name: "GCentroCusto",           foreign_key: "g_centro_custo_id",           optional: true
  belongs_to :tipo_combustivel,      class_name: "CTipoCombustivel",       foreign_key: "c_tipo_combustivel_id",       optional: true
  belongs_to :status,                class_name: "OStatus",                foreign_key: "o_status_id",                 optional: true
  belongs_to :voucher_validado_por,  class_name: "User",                   foreign_key: "voucher_validado_por_id",     optional: true
  belongs_to :empresa_fornecedora,    class_name: "FEmpresaFornecedora",    foreign_key: "f_empresa_fornecedora_id",    optional: true

  # ⚙️ Constantes e validações
  VOUCHER_STATUS = %w[pendente validado cancelado expirado].freeze

  validates :voucher_status, inclusion: { in: VOUCHER_STATUS }
  validates :voucher_codigo, uniqueness: true, allow_nil: true

  # ⚡ Callbacks
  before_create :gerar_voucher_codigo
  before_create :definir_validade_padrao

  # 🧠 Métodos auxiliares
  def voucher_expirado?
    voucher_validade.present? && voucher_validade < Time.current
  end

  private

  # Gera código único e legível do voucher
  def gerar_voucher_codigo
    loop do
      codigo = [
        SecureRandom.alphanumeric(4),
        SecureRandom.alphanumeric(4),
        SecureRandom.alphanumeric(4)
      ].map(&:upcase).join("-")

      unless self.class.exists?(voucher_codigo: codigo)
        self.voucher_codigo = codigo
        break
      end
    end
  end

  # Define validade padrão de 24 horas, se não definida
  def definir_validade_padrao
    self.voucher_validade ||= 24.hours.from_now
  end
end
