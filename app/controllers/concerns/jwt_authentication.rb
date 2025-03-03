module JwtAuthentication
  extend ActiveSupport::Concern

  def self.encode_token(user)
    payload = { user_id: user.id, exp: 24.hours.from_now.to_i }
    JWT.encode(payload, Rails.application.secret_key_base)
  end

  def self.encode_refresh_token(user)
    payload = { user_id: user.id, exp: 1.week.from_now.to_i }
    JWT.encode(payload, Rails.application.secret_key_base)
  end

  def self.decode_jwt(token)
    JWT.decode(token, Rails.application.secret_key_base)[0]
  rescue JWT::DecodeError
    nil
  end
end
