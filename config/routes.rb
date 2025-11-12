Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # Auth
      post "auth/login",   to: "auth#login"
      post "auth/refresh", to: "auth#refresh"

      resources :c_requisicoes_combustiveis, path: "requisicoes"
      post "vouchers/validate",              to: "vouchers#validate"

      # Outros endpoints
      resources :c_combustiveis,             path: "combustiveis"
      resources :g_veiculos,                 path: "veiculos"
      resources :c_postos,                   only: [ :index ], path: "postos"
      resources :c_tipos_combustiveis,       only: [ :index ], path: "tipos_combustivel"
    end
  end
end
