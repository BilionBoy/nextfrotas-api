# frozen_string_literal: true

module Api
  module V1
    class VouchersController < ApplicationController
      # POST /api/v1/vouchers/validate
      # Body: { "codigo": "ABCD-1234-EFGH", "c_posto_id": 1 }
      def validate
        codigo = params[:codigo].to_s.strip.upcase
        posto_id = params[:c_posto_id]

        # 🔍 Busca a requisição pelo código do voucher
        requisicao = CRequisicaoCombustivel.find_by(voucher_codigo: codigo)

        if requisicao.nil?
          render json: { error: "Voucher não encontrado" }, status: :not_found
          return
        end

        # ⛔ Já utilizado?
        if requisicao.voucher_status == "validado"
          render json: { error: "Voucher já foi utilizado" }, status: :unprocessable_entity
          return
        end

        # ⏳ Expirado?
        if requisicao.voucher_validade.present? && requisicao.voucher_validade < Time.current
          requisicao.update!(voucher_status: "expirado")
          render json: { error: "Voucher expirado" }, status: :unprocessable_entity
          return
        end

        # 🚫 Se informar um posto, validar se é o mesmo da requisição
        if posto_id.present? && requisicao.c_posto_id.present? && requisicao.c_posto_id.to_s != posto_id.to_s
          render json: { error: "Voucher não é válido para este posto" }, status: :forbidden
          return
        end

        # ✅ Tudo certo → marcar como validado
        requisicao.update!(
          voucher_status: "validado",
          voucher_validado_em: Time.current,
          voucher_validado_por_id: nil # por enquanto, sem autenticação
        )

        render json: {
          message: "Voucher validado com sucesso",
          requisicao: CRequisicaoCombustivelSerializer.new(requisicao)
        }, status: :ok
      end
    end
  end
end
