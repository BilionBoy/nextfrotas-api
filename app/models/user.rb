class User < ApplicationRecord
  # Sobrescreve o método 'password_digest' para usar 'encrypted_password'
  def password_digest
    self.encrypted_password
  end

  # Sobrescreve o método 'password_digest=' para gravar no campo 'encrypted_password'
  def password_digest=(value)
    self.encrypted_password = value
  end

  # Usa 'has_secure_password' para validação de senha
  has_secure_password

  validates :email, presence: true, uniqueness: true
end
