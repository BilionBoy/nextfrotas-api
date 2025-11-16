# frozen_string_literal: true

module Api
  module V1
    class GCentrosCustosController < ApplicationController
      include JsonResponse
      include PagyPagination
      before_action :require_gestor!

      # GET /api/v1/centros_custo
      def index
        centros = GCentroCusto
                    .where(a_unidade_id: current_user.a_unidade_id)
                    .includes(:g_tipo_centro_custo)

        pagy_data = paginate(centros, params[:per_page])

        render_success(
          message: "Centros de custo listados com sucesso",
          data: {
            pagy: pagy_data[:pagy],
            items: ActiveModelSerializers::SerializableResource.new(
              pagy_data[:items],
              each_serializer: GCentroCustoSerializer
            )
          }
        )
      end
    end
  end
end
