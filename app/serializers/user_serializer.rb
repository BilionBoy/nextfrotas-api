class UserSerializer
  def initialize(user)
    @user = user
  end

  def as_json(*)
    {
      id:           @user.id,
      nome:         @user.nome,
      email:        @user.email,
      tipo_usuario: @user.a_tipo_usuario&.descricao&.downcase,
      status:       @user.a_status&.descricao,
      unidade:      unidade_data,
      fornecedor:   fornecedor_data
    }
  end

  private

  def unidade_data
    return nil unless @user.a_unidade

    {
      id:   @user.a_unidade.id,
      nome: @user.a_unidade.nome_fantasia
    }
  end

  def fornecedor_data
    return nil unless @user.f_empresa_fornecedora

    {
      id:   @user.f_empresa_fornecedora.id,
      nome: @user.f_empresa_fornecedora.nome_fantasia
    }
  end
end
