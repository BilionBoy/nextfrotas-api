Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # Rota de autenticação
      post "auth/login",                          to: "auth#login"     # Para login com CPF e senha
      post "auth/refresh",                        to: "auth#refresh"   # Para renovar o token com o refresh_token

      resources :c_requisicoes_combustiveis,                        path: "requisicoes"
      resources :c_combustiveis,                                    path: "combustiveis"
      resources :c_postos,                        only: [ :index ], path: "postos"
      resources :c_tipos_combustiveis,            only: [ :index ], path: "tipos_combustivel"
    end
  end
end
