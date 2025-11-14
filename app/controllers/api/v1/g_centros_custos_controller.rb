module Api::V1
  class GCentrosCustosController < ApplicationController
    include JsonResponse
    include PagyPagination

    def index
      query = GCentroCusto.ransack(params[:q])
      response = paginate(query.result.order(:id), params[:per_page])
      render_success(data: response, message: "G centro custos listados com sucesso")
    end
  end
end
