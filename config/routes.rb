Rails.application.routes.draw do
  namespace :v1 do
    # Rota de autenticação
    post "auth/login",                      to: "auth#login"    # Para login com CPF e senha
    post "auth/refresh",                    to: "auth#refresh"  # Para renovar o token com o refresh_token

    resources :vw_analises_nutricionais,    only: %i[ index ], path: "analises"
    resources :vw_funcoes,                  only: %i[ index ], path: "funcoes"
    resources :vw_escolas_matriculas,       only: %i[ index ], path: "escolas_matriculas"
  end
end
