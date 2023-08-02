Feature:
  As a usuario
  I want to criar, editar, remover e visualizar reservas
  So that possa gerenciar o hotel

  # Os fixtures "reservas.yml", "quartos.yml" e "clientes.yml" estão sendo utilizados para o teste
  Scenario: marcar uma reserva
    Given Estou na pagina de cadastrar reserva
    When Eu preencho os dados:
      |      cliente       |       quarto       |       data_de_entrada      |  data_de_saida  | custo
      | Primeiro Cliente   | 1                  |     2057-04-10 01:20:30    | 2057-04-11 01:20:30  | 100.00
    Then Vejo que a reserva foi marcada

  Scenario: definir um tempo minimo de reserva
    Given Estou na pagina de cadastrar reserva
    When Eu preencho os dados:
      |      cliente       |       quarto       |       data_de_entrada      |  data_de_saida  | custo
      | Primeiro Cliente   | 1                  |     2057-04-10 01:20:30    | 2057-04-10 04:20:30  | 100.00
    Then Vejo que existe um periodo minimo de locacao

  Scenario: evitar choque entre reservas
    Given Estou na pagina de cadastrar reserva
    When Eu preencho os dados:
      |      cliente       |       quarto       |       data_de_entrada      |  data_de_saida  | custo
      | Primeiro Cliente   | 1                  |     2077-04-10 01:20:30    | 2078-04-10 04:20:30  | 100.00
    Then Vejo que existe um choque horario entre as reservas

  Scenario: editar a data de uma reserva
    Given Estou na pagina de reservas
    And Acesso uma reserva
    When Altero a data de entrada para "2077-05-12 02:20:30"
    Then Vejo que a reserva possui uma nova data de entrada

  Scenario: cancelar uma reserva
    Given Estou na pagina de reservas
    And Acesso uma reserva
    When Eu clico para cancelar essa reserva
    Then Vejo que essa reserva foi corretamente removida