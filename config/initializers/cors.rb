Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins "*"  # para dev pode deixar *, em prod use o domínio exato do frontend

    resource "*",
      headers: :any,
      methods: [ :get, :post, :put, :patch, :delete, :options, :head ],
      credentials: false
  end
end
