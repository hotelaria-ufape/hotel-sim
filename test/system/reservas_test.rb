require "application_system_test_case"

class ReservasTest < ApplicationSystemTestCase
  setup do
    @reserva = reservas(:one)
  end

  test "visiting the index" do
    visit reservas_url
    assert_selector "h1", text: "Reservas"
  end

  test "should create reserva" do
    visit reservas_url
    click_on "New reserva"

    fill_in "Cliente", with: @reserva.cliente_id
    fill_in "Custo", with: @reserva.custo
    fill_in "Data de entrada", with: @reserva.data_de_entrada
    fill_in "Data de saida", with: @reserva.data_de_saida
    fill_in "Quarto", with: @reserva.quarto_id
    click_on "Create Reserva"

    assert_text "Reserva was successfully created"
    click_on "Back"
  end

  test "should update Reserva" do
    visit reserva_url(@reserva)
    click_on "Edit this reserva", match: :first

    fill_in "Cliente", with: @reserva.cliente_id
    fill_in "Custo", with: @reserva.custo
    fill_in "Data de entrada", with: @reserva.data_de_entrada
    fill_in "Data de saida", with: @reserva.data_de_saida
    fill_in "Quarto", with: @reserva.quarto_id
    click_on "Update Reserva"

    assert_text "Reserva was successfully updated"
    click_on "Back"
  end

  test "should destroy Reserva" do
    visit reserva_url(@reserva)
    click_on "Destroy this reserva", match: :first

    assert_text "Reserva was successfully destroyed"
  end
end
