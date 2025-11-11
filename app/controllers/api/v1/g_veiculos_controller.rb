module Api::V1
  class GVeiculosController < ApplicationController
    include JsonResponse
    include PagyPagination

    def index
      query = GVeiculo.ransack(params[:q])
      response = paginate(query.result.order(:id), params[:per_page])
      render_success(data: response, message: "G veiculos listados com sucesso")
    end
  end
end
