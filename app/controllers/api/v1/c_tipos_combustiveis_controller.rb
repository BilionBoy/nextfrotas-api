module Api::V1
  class CTiposCombustiveisController < ApplicationController
    include JsonResponse
    include PagyPagination

    def index
      query = CTipoCombustivel.ransack(params[:q])
      response = paginate(query.result.order(:id), params[:per_page])
      render_success(data: response, message: "C tipo combustivels listados com sucesso")
    end
  end
end
