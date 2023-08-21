Feature:
  As a administrador
  I want to buscar clientes por cada atributo
  So that possa marcar uma reserva para o cliente certo

  @admin
  Scenario: buscar clientes por email
    Given estou na pagina de cadastrar 'clientes'
    And preencho os dados cpf '027.514.584-08' nome 'Cliente A' email 'anyemail@gmail.com' e telefone: 87912345678 e clico em cadastrar
    And vejo que o cliente 'Cliente A' foi cadastrado
    And estou na pagina de 'clientes'
    When seleciono o filtro de busca 'Email' de cliente
    And preencho o campo de busca de cliente com 'anyemail@gmail.com'
    And clico no botao procurar
    Then devo ver todos os clientes com 'anyemail@gmail.com' no campo 'Email'

  @admin
  Scenario: buscar clientes por cpf
    Given estou na pagina de cadastrar 'clientes'
    And preencho os dados cpf '027.514.584-08' nome 'Cliente A' email 'anyemail@gmail.com' e telefone: 87912345678 e clico em cadastrar
    And vejo que o cliente 'Cliente A' foi cadastrado
    And estou na pagina de 'clientes'
    When seleciono o filtro de busca 'CPF' de cliente
    And preencho o campo de busca de cliente com '027.514.584-08'
    And clico no botao procurar
    Then devo ver todos os clientes com '027.514.584-08' no campo 'CPF'

  @admin
  Scenario: buscar clientes por nome
    Given estou na pagina de cadastrar 'clientes'
    And preencho os dados cpf '027.514.584-08' nome 'Cliente A' email 'anyemail@gmail.com' e telefone: 87912345678 e clico em cadastrar
    And vejo que o cliente 'Cliente A' foi cadastrado
    And estou na pagina de 'clientes'
    When seleciono o filtro de busca 'Nome' de cliente
    And preencho o campo de busca de cliente com 'A'
    And clico no botao procurar
    Then devo ver todos os clientes com 'A' no campo 'Nome'