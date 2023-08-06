require "application_system_test_case"

class QuartosTest < ApplicationSystemTestCase
  setup do
    @quarto = quartos(:one)
  end

  test "visiting the index" do
    visit quartos_url
    assert_selector "h1", text: "Quartos"
  end

  test "should create quarto" do
    visit quartos_url
    click_on "New quarto"

    fill_in "Descricao", with: @quarto.descricao
    check "Disponibilidade" if @quarto.disponibilidade
    fill_in "Numero", with: @quarto.numero
    fill_in "Preco diaria", with: @quarto.preco_diaria
    fill_in "Tipo", with: @quarto.tipo
    fill_in "Quantidade de hospedes", with: @quato.quantidade_de_hospedes
    click_on "Create Quarto"

    assert_text "Quarto was successfully created"
    click_on "Back"
  end

  test "should update Quarto" do
    visit quarto_url(@quarto)
    click_on "Edit this quarto", match: :first

    fill_in "Descricao", with: @quarto.descricao
    check "Disponibilidade" if @quarto.disponibilidade
    fill_in "Numero", with: @quarto.numero
    fill_in "Preco diaria", with: @quarto.preco_diaria
    fill_in "Tipo", with: @quarto.tipo
    fill_in "Quantidade de hospedes", with: @quato.quantidade_de_hospedes
    click_on "Update Quarto"

    assert_text "Quarto was successfully updated"
    click_on "Back"
  end

  test "should destroy Quarto" do
    visit quarto_url(@quarto)
    click_on "Destroy this quarto", match: :first

    assert_text "Quarto was successfully destroyed"
  end
end
