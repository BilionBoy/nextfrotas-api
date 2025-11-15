class Api::V1::AuthController < ApplicationController
  skip_before_action :authorize_request, only: [ :login ]

  def login
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: user.id)

      render json: {
        token: token,
        user: UserSerializer.new(user).as_json
      }, status: :ok
    else
      render json: { error: "Credenciais inválidas" }, status: :unauthorized
    end
  end

  def me
    render_success(
      message: "Usuário autenticado",
      data: {
        user: UserSerializer.new(@current_user).as_json
      }
    )
  end
end
