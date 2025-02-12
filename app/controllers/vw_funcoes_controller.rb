class VwFuncoesController < ApplicationController
  include JsonResponse

  def index
    @funcoes = VwFuncao.group(:tipo_funcao).count

    data = @funcoes.map do |tipo, quantidade|
      { tipo_funcao: tipo, quantidade: quantidade }
    end

    render_json(status: "success", data: data, total: data.sum { |item| item[:quantidade] })
  rescue => e
    render_json(status: "error", data: { message: e.message }, status_code: 500)
  end

  def filter
    @funcoes = VwFuncao.where(tipo_funcao: params[:tipo]).count

    render_json(status: "success", data: [ { tipo_funcao: params[:tipo], quantidade: @funcoes } ])
  rescue ActiveRecord::RecordNotFound
    render_json(status: "error", data: { message: "Tipo de função não encontrado" }, status_code: 404)
  rescue => e
    render_json(status: "error", data: { message: e.message }, status_code: 500)
  end
end
