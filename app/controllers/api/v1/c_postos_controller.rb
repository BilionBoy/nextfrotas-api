module Api::V1
  class CPostosController < ApplicationController
    include JsonResponse
    include PagyPagination

    def index
      query = CPosto.ransack(params[:q])
      response = paginate(query.result.order(:id), params[:per_page])
      render_success(data: response, message: "C postos listados com sucesso")
    end
  end
end
