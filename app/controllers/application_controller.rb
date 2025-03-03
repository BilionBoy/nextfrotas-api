class ApplicationController < ActionController::API
  include Pagy::Backend
  include JwtAuthentication
  before_action :authenticate_user

  private

  def authenticate_user
    token = request.headers["Authorization"]&.split(" ")&.last
    decoded_token = JwtAuthentication.decode_jwt(token)
    if decoded_token
      @current_user = User.find(decoded_token["user_id"])
    else
      render json: { error: "Not authorized" }, status: :unauthorized
    end
  end
end
