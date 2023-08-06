require "test_helper"

class QuartosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @quarto = quartos(:one)
  end

  test "should get index" do
    get quartos_url
    assert_response :success
  end

  test "should get new" do
    get new_quarto_url
    assert_response :success
  end

  test "should create quarto" do
    assert_difference("Quarto.count") do
      post quartos_url, params: { quarto: { descricao: @quarto.descricao, disponibilidade: @quarto.disponibilidade, numero: @quarto.numero, preco_diaria: @quarto.preco_diaria, tipo: @quarto.tipo, quantidade_de_hospedes: @quarto.quantidade_de_hospedes } }
    end

    assert_redirected_to quarto_url(Quarto.last)
  end

  test "should show quarto" do
    get quarto_url(@quarto)
    assert_response :success
  end

  test "should get edit" do
    get edit_quarto_url(@quarto)
    assert_response :success
  end

  test "should update quarto" do
    patch quarto_url(@quarto), params: { quarto: { descricao: @quarto.descricao, disponibilidade: @quarto.disponibilidade, numero: @quarto.numero, preco_diaria: @quarto.preco_diaria, tipo: @quarto.tipo, quantidade_de_hospedes: @quarto.quantidade_de_hospedes } }
    assert_redirected_to quarto_url(@quarto)
  end

  test "should destroy quarto" do
    assert_difference("Quarto.count", -1) do
      delete quarto_url(@quarto)
    end

    assert_redirected_to quartos_url
  end
end
