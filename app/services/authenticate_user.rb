class AuthenticateUser
  def self.call(cpf, password)
    user = User.find_by(cpf: cpf)

    return { error: "Invalid credentials" } unless user&.authenticate(password)

    token =         JwtAuthentication.encode_token(user)
    refresh_token = JwtAuthentication.encode_refresh_token(user)

    { token: token, refresh_token: refresh_token }
  end
end
