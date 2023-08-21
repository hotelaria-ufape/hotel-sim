Feature:
  As a administrador
  I want to buscar reservas por cada atributo
  So that possa ver os dados de uma reserva corretamente

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