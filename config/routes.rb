Rails.application.routes.draw do
  resources :vw_analises_nutricionais,     only: [ :index ], path: "analises"
  resources :vw_funcoes,                   only: [ :index ], path: "funcoes"
end
