# frozen_string_literal: true

module Api
  module V1
    class VouchersController < ApplicationController
      def validate
        codigo = params[:codigo].to_s.strip.upcase
        requisicao = CRequisicaoCombustivel.find_by(voucher_codigo: codigo)

        if requisicao.nil?
          render json: { error: "Voucher não encontrado" }, status: :not_found
          return
        end

        # Já validado?
        if requisicao.voucher_status == "validado"
          render json: { error: "Voucher já foi utilizado" }, status: :unprocessable_entity
          return
        end

        # Expirado?
        if requisicao.voucher_expirado?
          requisicao.update!(voucher_status: "expirado")
          render json: { error: "Voucher expirado" }, status: :unprocessable_entity
          return
        end

        # 🚀🚀🚀 NOVA VALIDAÇÃO POR EMPRESA (regra correta)
        if requisicao.f_empresa_fornecedora_id != current_user.f_empresa_fornecedora_id
          render json: { error: "Voucher pertence a outra empresa" }, status: :forbidden
          return
        end

        # Validar voucher
        requisicao.update!(
          voucher_status: "validado",
          voucher_validado_em: Time.current,
          voucher_validado_por_id: current_user.id
        )

        render json: {
          message: "Voucher validado com sucesso",
          requisicao: CRequisicaoCombustivelSerializer.new(requisicao)
        }, status: :ok
      end
    end
  end
end
