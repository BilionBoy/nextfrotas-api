# app/controllers/api/v1/c_postos_controller.rb
class Api::V1::CPostosController < ApplicationController
  before_action :set_posto, only: [ :show, :update, :destroy ]

  # GET /api/v1/c_postos
  def index
    postos = CPosto.all
    render json: postos
  end

  # GET /api/v1/c_postos/:id
  def show
    render json: @posto
  end

  # POST /api/v1/c_postos
  def create
    posto = CPosto.new(posto_params)
    if posto.save
      render json: posto, status: :created
    else
      render json: { errors: posto.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PUT /api/v1/c_postos/:id
  def update
    if @posto.update(posto_params)
      render json: @posto
    else
      render json: { errors: @posto.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/c_postos/:id
  def destroy
    @posto.destroy
    head :no_content
  end

  private

  def set_posto
    @posto = CPosto.find(params[:id])
  end

  def posto_params
    params.require(:c_posto).permit(
      :nome_fantasia,
      :razao_social,
      :cnpj,
      :endereco,
      :telefone,
      :email,
      :saldo_prepago,
      :g_municipio_id,
      :g_estado_id,
      :a_status_id
    )
  end
end
