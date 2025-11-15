module AuthorizeRequest
  extend ActiveSupport::Concern

  included do
    before_action :authorize_request
    attr_reader   :current_user
  end

  private

  # AUTENTICAÇÃO
  def authorize_request
    header = request.headers["Authorization"]

    if header.blank?
      return render_error(message: "Token não fornecido", status: :unauthorized)
    end

    token = header.split(" ").last

    begin
      decoded = JsonWebToken.decode(token)
      @current_user = User.find(decoded[:user_id])

    rescue ActiveRecord::RecordNotFound
      render_error(message: "Usuário não encontrado", status: :unauthorized)
    rescue JWT::ExpiredSignature
      render_error(message: "Token expirado", status: :unauthorized)
    rescue JWT::DecodeError
      render_error(message: "Token inválido", status: :unauthorized)
    end
  end

  # AUTORIZAÇÃO

  def require_admin!
    unless current_user&.a_tipo_usuario&.descricao&.downcase == "admin"
      render_error(message: "Acesso permitido apenas para administradores", status: :forbidden)
    end
  end

  def require_gestor!
    unless current_user&.a_tipo_usuario&.descricao&.downcase == "gestor"
      render_error(message: "Acesso permitido apenas para gestores", status: :forbidden)
    end
  end

  def require_posto!
    unless current_user&.a_tipo_usuario&.descricao&.downcase == "fornecedor"
      render_error(message: "Acesso permitido apenas para postos", status: :forbidden)
    end
  end
end
