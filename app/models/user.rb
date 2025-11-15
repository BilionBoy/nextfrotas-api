class User < ApplicationRecord
  self.table_name = "users"

  belongs_to :a_tipo_usuario
  belongs_to :a_unidade, optional: true
  belongs_to :a_status, optional: true
  belongs_to :f_empresa_fornecedora, optional: true

  # A API NÃO usa encrypted_password, mas sim password_digest
  def password_digest
    self.encrypted_password
  end

  has_secure_password validations: false

  # Helpers iguais ao MVC (sem devise, mas funcionando)
  def admin?
    a_tipo_usuario&.descricao&.downcase == "admin"
  end

  def gestor?
    a_tipo_usuario&.descricao&.downcase == "gestor"
  end

  def fornecedor?
    a_tipo_usuario&.descricao&.downcase == "fornecedor"
  end
end
