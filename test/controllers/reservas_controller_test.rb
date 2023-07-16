require "test_helper"

class ReservasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @reserva = reservas(:one)
  end

  test "should get index" do
    get reservas_url, as: :json
    assert_response :success
  end

  test "should create reserva" do
    assert_difference("Reserva.count") do
      post reservas_url, params: { reserva: { cliente_id: @reserva.cliente_id, custo: @reserva.custo, data_de_entrada: @reserva.data_de_entrada, data_de_saida: @reserva.data_de_saida, quarto_id: @reserva.quarto_id } }, as: :json
    end

    assert_response :created
  end

  test "should show reserva" do
    get reserva_url(@reserva), as: :json
    assert_response :success
  end

  test "should update reserva" do
    patch reserva_url(@reserva), params: { reserva: { cliente_id: @reserva.cliente_id, custo: @reserva.custo, data_de_entrada: @reserva.data_de_entrada, data_de_saida: @reserva.data_de_saida, quarto_id: @reserva.quarto_id } }, as: :json
    assert_response :success
  end

  test "should destroy reserva" do
    assert_difference("Reserva.count", -1) do
      delete reserva_url(@reserva), as: :json
    end

    assert_response :no_content
  end
end
