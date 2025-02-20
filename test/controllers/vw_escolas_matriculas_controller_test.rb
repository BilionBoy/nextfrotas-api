require "test_helper"

class VwEscolasMatriculasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @vw_escolas_matricula = vw_escolas_matriculas(:one)
  end

  test "should get index" do
    get vw_escolas_matriculas_url, as: :json
    assert_response :success
  end

  test "should create vw_escolas_matricula" do
    assert_difference("VwEscolasMatricula.count") do
      post vw_escolas_matriculas_url, params: { vw_escolas_matricula: {} }, as: :json
    end

    assert_response :created
  end

  test "should show vw_escolas_matricula" do
    get vw_escolas_matricula_url(@vw_escolas_matricula), as: :json
    assert_response :success
  end

  test "should update vw_escolas_matricula" do
    patch vw_escolas_matricula_url(@vw_escolas_matricula), params: { vw_escolas_matricula: {} }, as: :json
    assert_response :success
  end

  test "should destroy vw_escolas_matricula" do
    assert_difference("VwEscolasMatricula.count", -1) do
      delete vw_escolas_matricula_url(@vw_escolas_matricula), as: :json
    end

    assert_response :no_content
  end
end
