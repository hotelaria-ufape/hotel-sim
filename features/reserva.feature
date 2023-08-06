Feature:
  As a usuario
  I want to criar, editar, remover e visualizar reservas
  So that possa gerenciar o hotel

  Scenario: marcar uma reserva
    Given Estou na pagina de cadastrar reserva apos cadastrar o cliente "Cliente A" e o quarto 15
    When Eu preencho os dados cliente "Cliente A" quarto "15" data_de_entrada "2057-04-10 01:20:30" data_de_saida "2057-04-11 01:20:30" custo "100.00"
    Then Vejo que a reserva foi marcada

  Scenario: definir um tempo minimo de reserva
    Given Estou na pagina de cadastrar reserva apos cadastrar o cliente "Cliente A" e o quarto 15
    When Eu preencho os dados cliente "Cliente A" quarto "15" data_de_entrada "2097-04-10 01:20:30" data_de_saida "2097-04-10 04:20:30" custo "100.00"
    Then Vejo que existe um periodo minimo de locacao

  Scenario: cancelar uma reserva
    Given Estou na pagina de cadastrar reserva apos cadastrar o cliente "Cliente A" e o quarto 15
    And Eu preencho os dados cliente "Cliente A" quarto "15" data_de_entrada "2097-04-10 01:20:30" data_de_saida "2097-04-11 01:20:30" custo "100.00"
    And Vejo que a reserva foi marcada
    When Clico para cancelar essa reserva
    Then Vejo que essa reserva foi corretamente removida

  Scenario: choque entre reservas
    Given Estou na pagina de cadastrar reserva apos cadastrar o cliente "Cliente A" o cliente "Cliente B" e o quarto 15
    And Eu preencho os dados cliente "Cliente A" quarto "15" data_de_entrada "2098-01-10 04:20:30" data_de_saida "2098-01-11 04:20:30" custo "100.00"
    And Vejo que a reserva foi marcada
    When Eu preencho os dados cliente "Cliente B" quarto "15" data_de_entrada "2098-01-11 02:20:30" data_de_saida "2098-01-11 14:20:30" custo "50.00"
    Then Vejo que existe um choque de horario entre essas reservas

  Scenario: buscar reservas por periodo
    Given Estou na pagina de cadastrar reserva apos cadastrar o cliente "Cliente A" o cliente "Cliente B" e o quarto 15
    And Eu preencho os dados cliente "Cliente A" quarto "15" data_de_entrada "2098-01-10 04:20:30" data_de_saida "2098-01-11 04:20:30" custo "100.00"
    And Vejo que a reserva foi marcada
    When Eu preencho os dados cliente "Cliente B" quarto "15" data_de_entrada "2098-01-16 02:20:30" data_de_saida "2098-01-16 14:20:30" custo "50.00"
    And Vejo que a reserva foi marcada
    And Estou na pagina de reservas
    And Seleciono a data de entrada "2098-01-09 01:30:25"
    And Seleciono a data de saida "2098-01-14 04:20:30"
    When Clico em filtrar
    Then Vejo apenas a reserva do "Cliente A" marcada nesse periodo