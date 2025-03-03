# app/models/user.rb
class User < ApplicationRecord
  self.table_name = "users"

  # Sobrescrevendo para usar `encrypted_password` como `password_digest`
  def password_digest
    encrypted_password
  end

  has_secure_password  # Habilita autenticação baseada em bcrypt

  validates :email, presence: true, uniqueness: true
end
