require "test_helper"

class QuartoTest < ActiveSupport::TestCase
  test 'Criando quarto sem preencher dados' do
    quarto = Quarto.new
    assert_not quarto.save
  end

  test 'Criando quarto com dados validos' do
    quarto = Quarto.new numero:'3', tipo:'Quarto Padrão', disponibilidade: true,
                        preco_diaria:150.00, descricao:'Quarto de entrada do nosso hotel.', quantidade_de_hospedes:2
    assert quarto.save, "Não foi possível salvar o quarto: #{quarto.errors.full_messages.join(', ')}"
  end

  test 'Criando quarto com numero invalido' do
    quarto = Quarto.new numero:'abc', tipo:'Quarto Padrão', disponibilidade: true,
                        preco_diaria:150.00, descricao:'Quarto de entrada do nosso hotel.', quantidade_de_hospedes:2
    assert_not quarto.save
  end
  # test "the truth" do
  #   assert true
  # end
end
