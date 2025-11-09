Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # Rota de autenticação
      post "auth/login",                          to: "auth#login"     # Para login com CPF e senha
      post "auth/refresh",                        to: "auth#refresh"   # Para renovar o token com o refresh_token

      resources :c_postos,                        only: [ :index ], path: "postos"
    end
  end
end
