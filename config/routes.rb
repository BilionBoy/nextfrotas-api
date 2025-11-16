Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :c_requisicoes_combustiveis, path: "requisicoes" do
        collection do
          get :find_by_code
        end
        member do
          patch :validar_voucher
        end
      end

      resources :c_combustiveis,                          path: "combustiveis"
      resources :a_unidades,            only: [ :index ], path: "unidades"
      resources :c_postos,              only: [ :index ], path: "postos"
      resources :c_tipos_combustiveis,  only: [ :index ], path: "tipos_combustivel"
      resources :g_centros_custos,      only: [ :index ], path: "centros_custo"
      resources :g_tipos_veiculos,      only: [ :index ], path: "tipos_veiculo"
      resources :g_veiculos,                              path: "veiculos"

      post "auth/login",   to: "auth#login"
      post "auth/refresh", to: "auth#refresh"
      get  "auth/me",      to: "auth#me"
    end
  end
end
