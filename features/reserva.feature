Feature:
  As a administrador
  I want to criar, editar, remover e visualizar reservas
  So that possa gerenciar o hotel

  @admin
  Scenario: marcar uma reserva
    Given estou na pagina de cadastrar reserva apos cadastrar o cliente "Cliente A" e o quarto 15
    When preencho os dados cliente "Cliente A" quarto "15" data_de_entrada "2057-04-10 01:20:30" data_de_saida "2057-04-11 01:20:30" custo "100.00"
    Then vejo que a reserva foi marcada

  @admin
  Scenario: editar uma reserva
    Given estou na pagina de cadastrar reserva apos cadastrar o cliente "Cliente A" e o quarto 15
    When preencho os dados cliente "Cliente A" quarto "15" data_de_entrada "2057-04-10 01:20:30" data_de_saida "2057-04-11 01:20:30" custo "100.00"
    And vejo que a reserva foi marcada
    And clico para editar o 'data de saida' da reserva do 'Cliente A' para '2057-04-12 01:20:30'
    Then vejo que a reserva do 'Cliente A' teve seu 'data de saida' corretamente alterado para '2057-04-12 01:20:30'

  @admin
  Scenario: cancelar uma reserva
    Given estou na pagina de cadastrar reserva apos cadastrar o cliente "Cliente A" e o quarto 15
    And preencho os dados cliente "Cliente A" quarto "15" data_de_entrada "2097-04-10 01:20:30" data_de_saida "2097-04-11 01:20:30" custo "100.00"
    And vejo que a reserva foi marcada
    When clico para cancelar essa reserva
    Then vejo que essa reserva foi corretamente removida

  @admin
  Scenario: definir um tempo minimo de reserva
    Given estou na pagina de cadastrar reserva apos cadastrar o cliente "Cliente A" e o quarto 15
    When preencho os dados cliente "Cliente A" quarto "15" data_de_entrada "2097-04-10 01:20:30" data_de_saida "2097-04-10 04:20:30" custo "100.00"
    Then vejo que existe um periodo minimo de locacao

  @admin
  Scenario: choque entre reservas
    Given estou na pagina de cadastrar reserva apos cadastrar o cliente "Cliente A" o cliente "Cliente B" e o quarto 15
    And preencho os dados cliente "Cliente A" quarto "15" data_de_entrada "2098-01-10 04:20:30" data_de_saida "2098-01-11 04:20:30" custo "100.00"
    And vejo que a reserva foi marcada
    When preencho os dados cliente "Cliente B" quarto "15" data_de_entrada "2098-01-11 02:20:30" data_de_saida "2098-01-11 14:20:30" custo "50.00"
    Then vejo que existe um choque de horario entre essas reservas

  @admin
  Scenario: buscar reservas por periodo
    Given estou na pagina de cadastrar reserva apos cadastrar o cliente "Cliente A" o cliente "Cliente B" e o quarto 15
    And preencho os dados cliente "Cliente A" quarto "15" data_de_entrada "2098-01-10 04:20:30" data_de_saida "2098-01-11 04:20:30" custo "100.00"
    And vejo que a reserva foi marcada
    When preencho os dados cliente "Cliente B" quarto "15" data_de_entrada "2098-01-16 02:20:30" data_de_saida "2098-01-16 14:20:30" custo "50.00"
    And vejo que a reserva foi marcada
    And estou na pagina de 'reservas'
    And seleciono o filtro de busca 'Data' de reserva
    And seleciono a data de entrada "2098-01-09 01:30:25" na busca
    And seleciono a data de saida "2098-01-14 04:20:30" na busca
    When clico em filtrar
    Then vejo apenas a reserva do "Cliente A" marcada nesse periodo