require "test_helper"

class QuartoTest < ActiveSupport::TestCase
  test 'Criando quarto sem preencher dados' do
    quarto = Quarto.new
    assert_not quarto.save
  end

  test 'Criando quarto com dados validos' do
    quarto = Quarto.new numero:'1', tipo:'Quarto Padrão', disponibilidade: true,
                        preco_diaria:150.00, descricao:'Quarto de entrada do nosso hotel.'
    assert quarto.save
  end

  test 'Criando quarto com numero invalido' do
    quarto = Quarto.new numero:'abc', tipo:'Quarto Padrão', disponibilidade: true,
                        preco_diaria:150.00, descricao:'Quarto de entrada do nosso hotel.'
    assert_not quarto.save
  end
  # test "the truth" do
  #   assert true
  # end
end
