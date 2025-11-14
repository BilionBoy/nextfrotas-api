Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # Auth
      # Combustível
      resources :c_combustiveis,                         path: "combustiveis"
      resources :c_requisicoes_combustiveis,             path: "requisicoes"
      resources :c_tipos_combustiveis, only: [ :index ], path: "tipos_combustivel"
      resources :c_postos,             only: [ :index ], path: "postos"

      # Frota
      resources :a_status,             only: [ :index ], path: "status"
      resources :a_unidades,           only: [ :index ], path: "unidades"
      resources :g_tipos_veiculos,     only: [ :index ], path: "tipos_veiculo"
      resources :g_centros_custos,     only: [ :index ], path: "centros_custo"
      resources :g_veiculos,                             path: "veiculos"


      post "auth/login",   to: "auth#login"
      post "auth/refresh", to: "auth#refresh"

      # Requisição combustível
      post "vouchers/validate", to: "vouchers#validate"
    end
  end
end
