Feature:
  As a administrador
  I want to criar, editar, remover e visualizar clientes
  So that possa manter atualizando o cadastro

  @admin
  Scenario: cadastrar um cliente
    Given estou na pagina de cadastrar 'clientes'
    When preencho os dados cpf '027.514.584-08' nome 'Cliente A' email 'clienteA@gmail.com' e telefone: 87912345678 e clico em cadastrar
    Then vejo que o cliente 'Cliente A' foi cadastrado

  @admin
  Scenario: validar o cpf do cliente
    Given estou na pagina de cadastrar 'clientes'
    When preencho os dados cpf '123.456.789-10' nome 'Cliente A' email 'clienteA@gmail.com' e telefone: 87912345678 e clico em cadastrar
    Then vejo que o cliente 'Cliente A' nao foi cadastrado
    And vejo que seu cpf e invalido

  @admin
  Scenario: validar o email do cliente
    Given estou na pagina de cadastrar 'clientes'
    And preencho os dados cpf '027.514.584-08' nome 'Cliente A' email 'clienteA@gmail.com' e telefone: 87912345678 e clico em cadastrar
    And vejo que o cliente 'Cliente A' foi cadastrado
    And estou na pagina de cadastrar 'clientes'
    When preencho os dados cpf '053.209.150-71' nome 'Cliente B' email 'clienteA@gmail.com' e telefone: 87912345678 e clico em cadastrar
    Then vejo que o cliente 'Cliente B' nao foi cadastrado
    And vejo que seu email e invalido

  @admin
  Scenario: remover um cliente
    Given estou na pagina de cadastrar 'clientes'
    And preencho os dados cpf '027.514.584-08' nome 'Cliente A' email 'clienteA@gmail.com' e telefone: 87912345678 e clico em cadastrar
    And vejo que o cliente 'Cliente A' foi cadastrado
    When clico para remover o cliente 'Cliente A'
    Then vejo que o cliente 'Cliente A' foi corretamente removido

  @admin
  Scenario: editar dados de um cliente
    Given estou na pagina de cadastrar 'clientes'
    And preencho os dados cpf '027.514.584-08' nome 'Cliente A' email 'clienteA@gmail.com' e telefone: 87912345678 e clico em cadastrar
    And vejo que o cliente 'Cliente A' foi cadastrado
    When clico para editar o 'telefone' do cliente 'Cliente A' para '88812345678'
    Then vejo que o cliente 'Cliente A' teve seu 'telefone' corretamente alterado para '88812345678'