class ATipoUsuario < ApplicationRecord
  self.table_name = "a_tipo_usuarios"

  has_many :users

  # opcional para facilitar no futuro
  scope :ativos, -> { where(deleted_at: nil) }
end
