Feature:
  As a usuario
  I want to criar, editar, remover e visualizar clientes
  So that possa manter atualizando o cadastro

  Scenario: cadastrar um cliente
    Given Estou na pagina de cadastrar cliente
    When Eu preencho os dados cpf '027.514.584-08' nome 'Cliente A' email 'clienteA@gmail.com' e telefone: 87912345678 e clico em cadastrar
    Then Vejo que o meu cadastro foi realizado

  Scenario: validar o cpf do cliente
    Given Estou na pagina de cadastrar cliente
    When Eu preencho os dados cpf '123.456.789-10' nome 'Cliente A' email 'clienteA@gmail.com' e telefone: 87912345678 e clico em cadastrar
    Then Eu vejo que meu cpf e invalido

  Scenario: validar o email do cliente
    Given Estou na pagina de cadastrar cliente
    And O cliente de cpf '027.514.584-08' nome 'Cliente A' email 'clienteA@gmail.com' e telefone: 87912345678 existe
    And Estou na pagina de cadastrar cliente
    When Eu preencho os dados cpf '053.209.150-71' nome 'Cliente B' email 'clienteA@gmail.com' e telefone: 87912345678 e clico em cadastrar
    Then Eu vejo que meu email e invalido

  Scenario: remover um cliente
    Given Estou na pagina de clientes
    And O cliente de cpf '027.514.584-08' nome 'Cliente A' email 'clienteA@gmail.com' e telefone: 87912345678 existe
    When Eu clico para remover esse cliente
    Then Eu vejo que o cliente 'Cliente A' foi corretamente removido

  Scenario: editar dados de um cliente
    Given Estou na pagina de clientes
    And O cliente de cpf '027.514.584-08' nome 'Cliente A' email 'clienteA@gmail.com' e telefone: 87912345678 existe
    When Eu clico para editar seu telefone para '88812345678'
    Then Eu vejo que o cliente teve seu telefone corretamente alterado para '88812345678'