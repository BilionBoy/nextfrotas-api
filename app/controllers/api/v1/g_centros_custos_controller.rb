# frozen_string_literal: true

module Api
  module V1
    class GCentrosCustosController < ApplicationController
      include JsonResponse
      before_action :require_gestor!

      # GET /api/v1/centros_custos
      def index
        centros = GCentroCusto
                    .where(a_unidade_id: current_user.a_unidade_id)
                    .includes(:g_tipo_centro_custo)

        render_success(
          message: "Centros de custo listados com sucesso",
          data: ActiveModelSerializers::SerializableResource.new(
            centros,
            each_serializer: GCentroCustoSerializer
          )
        )
      end
    end
  end
end
