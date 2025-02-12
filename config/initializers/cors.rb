Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins "*" # Ou substitua '*' pela URL do seu frontend (ex: 'https://meufrontend.com')

    resource "*", # Permite qualquer recurso
      headers: :any, # Permite qualquer cabeçalho
      methods: [ :get, :options ], # Permite apenas GET e OPTIONS
      credentials: false # Não é necessário enviar cookies ou credenciais
  end
end
