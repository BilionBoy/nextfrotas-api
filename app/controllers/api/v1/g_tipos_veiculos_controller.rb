module Api::V1
  class GTiposVeiculosController < ApplicationController
    include JsonResponse
    include PagyPagination

    def index
      query = GTipoVeiculo.ransack(params[:q])
      response = paginate(query.result.order(:id), params[:per_page])
      render_success(data: response, message: "G tipo veiculos listados com sucesso")
    end
  end
end
