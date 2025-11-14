module Api::V1
  class AUnidadesController < ApplicationController
    include JsonResponse
    include PagyPagination

    def index
      query = AUnidade.ransack(params[:q])
      response = paginate(query.result.order(:id), params[:per_page])
      render_success(data: response, message: "A unidades listados com sucesso")
    end
  end
end
