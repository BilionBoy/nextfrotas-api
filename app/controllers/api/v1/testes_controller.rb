module Api::V1
  class TestesController < ApplicationController
    include JsonResponse
    include PagyPagination
    
    def index
      query = Teste.ransack(params[:q])
      response = paginate(query.result.order(:id), params[:per_page])
      render_success(data: response, message: "Testes listados com sucesso")
    end
  end
end
