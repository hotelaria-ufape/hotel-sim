require "test_helper"

class ReservaTest < ActiveSupport::TestCase
  test 'Marcando reserva valida' do
    reserva = Reserva.new cliente: clientes(:one), quarto: quartos(:two), data_de_entrada: '2077-05-15 01:20:30',
                          data_de_saida: '2077-05-17 10:20:30', custo: 712.50
    assert reserva.save, "Não foi possível salvar o cliente: #{reserva.errors.full_messages.join(', ')}"
  end

  test 'Marcando reserva invalida' do
    reserva = Reserva.new cliente: clientes(:two), quarto: quartos(:two), data_de_entrada: '2017-05-16 02:20:30',
                          data_de_saida: '2027-05-16 10:20:30', custo: 93.78
    assert_not reserva.save
  end

  test 'Removendo reserva' do
    reserva = reservas(:one)
    assert reserva.delete
  end
end
