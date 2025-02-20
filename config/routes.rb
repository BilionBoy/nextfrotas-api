Rails.application.routes.draw do
  namespace :v1 do
    resources :vw_analises_nutricionais,   only: [:index], path: "analises"
    resources :vw_funcoes,                 only: [:index], path: "funcoes"
    resources :vw_escolas_matriculas,      only: [:index], path: "escolas_matriculas"
  end
end
