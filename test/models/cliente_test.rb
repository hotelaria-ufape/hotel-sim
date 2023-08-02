require "test_helper"

class ClienteTest < ActiveSupport::TestCase
  test 'Criando cliente sem preencher dados' do
    cliente = Cliente.new
    assert_not cliente.save
  end

  test 'Criando cliente com dados validos' do
    cliente = Cliente.new cpf:'856.734.020-90', nome:'Terceiro Cliente', email:'terceirocliente@gmail.com', telefone:87912345678
    assert cliente.save, "Não foi possível salvar o cliente: #{cliente.errors.full_messages.join(', ')}"
  end

  test 'Criando cliente com cpf invalido' do
    cliente = Cliente.new cpf:'123.456.789-10', nome:'Quarto Cliente', email:'quartocliente@gmail.com', telefone:87912345678
    assert_not cliente.save
  end
end
