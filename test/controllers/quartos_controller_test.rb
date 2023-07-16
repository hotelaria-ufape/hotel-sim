require "test_helper"

class QuartosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @quarto = quartos(:one)
  end

  test "should get index" do
    get quartos_url, as: :json
    assert_response :success
  end

  test "should create quarto" do
    assert_difference("Quarto.count") do
      post quartos_url, params: { quarto: { descricao: @quarto.descricao, disponibilidade: @quarto.disponibilidade, numero: @quarto.numero, preco_diaria: @quarto.preco_diaria, tipo: @quarto.tipo } }, as: :json
    end

    assert_response :created
  end

  test "should show quarto" do
    get quarto_url(@quarto), as: :json
    assert_response :success
  end

  test "should update quarto" do
    patch quarto_url(@quarto), params: { quarto: { descricao: @quarto.descricao, disponibilidade: @quarto.disponibilidade, numero: @quarto.numero, preco_diaria: @quarto.preco_diaria, tipo: @quarto.tipo } }, as: :json
    assert_response :success
  end

  test "should destroy quarto" do
    assert_difference("Quarto.count", -1) do
      delete quarto_url(@quarto), as: :json
    end

    assert_response :no_content
  end
end
