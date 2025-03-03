module V1
  class AuthController < ApplicationController
    skip_before_action :authenticate_user, only: [ :login, :refresh ]

    def login
      result = AuthenticateUser.call(params[:cpf], params[:password])
      if result[:token]
        render json: { token: result[:token], refresh_token: result[:refresh_token] }, status: :ok
      else
        render_error(result[:error])
      end
    end

    def refresh
      decoded_token = JwtAuthentication.decode_jwt(params[:refresh_token])
      if decoded_token
        user = User.find(decoded_token["user_id"])
        token_manager = TokenManager.new(user)
        render json: { token: token_manager.encode_access_token }, status: :ok
      else
        render_error("Invalid refresh token")
      end
    end

    private

    def render_error(message)
      render json: { error: message }, status: :unauthorized
    end
  end
end
