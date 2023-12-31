Feature:
  As a administrador
  I want to criar, editar, remover e visualizar cadastros de quartos
  So that possa manter atualizando o cadastro

  @admin
  Scenario: cadastrar um quarto
    Given estou na pagina de cadastrar 'quartos'
    When preencho os dados do quarto numero 5 tipo 'Quarto Padrão' disponibilidade 'Disponível' preco_diaria '150.0' descricao 'Esse é o quarto de entrada' quantidade_de_hospedes 1 e clico em cadastrar
    Then vejo que o quarto 5 foi cadastrado

  @admin
  Scenario: alterar disponibilidade do quarto
    Given estou na pagina de cadastrar 'quartos'
    And preencho os dados do quarto numero 7 tipo 'Quarto Padrão' disponibilidade 'Disponível' preco_diaria '150.0' descricao 'Esse é o quarto de entrada' quantidade_de_hospedes 2 e clico em cadastrar
    And vejo que o quarto 7 foi cadastrado
    When clico para editar o 'disponibilidade' do quarto 7 para 'Indisponível'
    Then vejo que o quarto 7 teve seu 'disponibilidade' corretamente alterado para 'Indisponível'

  @admin
  Scenario: alterar o preco da diaria do quarto
    Given estou na pagina de cadastrar 'quartos'
    And preencho os dados do quarto numero 8 tipo 'Quarto Padrão' disponibilidade 'Disponível' preco_diaria '160.0' descricao 'Esse é o quarto de entrada' quantidade_de_hospedes 2 e clico em cadastrar
    And vejo que o quarto 8 foi cadastrado
    When clico para editar o 'preco da diaria' do quarto 8 para '50.0'
    Then vejo que o quarto 8 teve seu 'preco da diaria' corretamente alterado para '50.0'

  @admin
  Scenario: remover um quarto
    Given estou na pagina de cadastrar 'quartos'
    And preencho os dados do quarto numero 6 tipo 'Quarto Padrão' disponibilidade 'Disponível' preco_diaria '150.0' descricao 'Esse é o quarto de entrada' quantidade_de_hospedes 1 e clico em cadastrar
    Then vejo que o quarto 6 foi cadastrado
    When clico para remover o quarto 6
    Then vejo que o quarto 6 foi corretamente removido