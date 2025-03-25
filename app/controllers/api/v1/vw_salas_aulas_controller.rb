module Api::V1
  class VwSalasAulasController < ApplicationController
    include JsonResponse
    include PagyPagination

    def index
      query = VwSalaAula.ransack(params[:q])
      pagy, records = pagy(query.result.order(:id), items: params[:per_page])

      # Serializando apenas os campos desejados
      serialized_data = records.as_json(only: [ :escola, :cre, :capacidade, :tipo_sala, :id ])

      render_success(data: serialized_data, message: "Vw sala aulas listados com sucesso")
    end
  end
end
