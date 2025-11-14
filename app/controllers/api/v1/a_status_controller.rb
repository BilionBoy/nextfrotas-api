module Api::V1
  class AStatusController < ApplicationController
    include JsonResponse
    include PagyPagination

    def index
      query = AStatus.ransack(params[:q])
      response = paginate(query.result.order(:id), params[:per_page])
      render_success(data: response, message: "A statuses listados com sucesso")
    end
  end
end
