module Api::V1
  class VwAnalisesNutricionaisController < ApplicationController
    include JsonResponse
    include PagyPagination

    def index
      query = VwAnaliseNutricional.ransack(params[:q])
      response = paginate(query.result.order(:id), params[:per_page])
      render_success(data: response, message: "Valores listados com sucesso")
    end
  end
end
