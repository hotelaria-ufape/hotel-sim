Feature:
  As a usuario
  I want to criar, editar, remover e visualizar cadastros de quartos
  So that possa manter atualizando o cadastro

  Scenario: cadastrar um quarto
    Given estou na pagina de cadastrar 'quartos'
    When preencho os dados do quarto numero 5 tipo 'Quarto Padrão' disponibilidade 'Disponível' preco_diaria '150.0' descricao 'Esse é o quarto de entrada' quantidade_de_hospedes 1 e clico em cadastrar
    Then vejo que o quarto 5 foi cadastrado

  Scenario: remover um quarto
    Given estou na pagina de cadastrar 'quartos'
    And preencho os dados do quarto numero 6 tipo 'Quarto Padrão' disponibilidade 'Disponível' preco_diaria '150.0' descricao 'Esse é o quarto de entrada' quantidade_de_hospedes 1 e clico em cadastrar
    Then vejo que o quarto 6 foi cadastrado
    When clico para remover o quarto 6
    Then vejo que o quarto 6 foi corretamente removido

  Scenario: alterar disponibilidade do quarto
    Given estou na pagina de cadastrar 'quartos'
    And preencho os dados do quarto numero 7 tipo 'Quarto Padrão' disponibilidade 'Disponível' preco_diaria '150.0' descricao 'Esse é o quarto de entrada' quantidade_de_hospedes 2 e clico em cadastrar
    And vejo que o quarto 7 foi cadastrado
    When clico para editar o 'disponibilidade' do quarto 7 para 'Indisponível'
    Then vejo que o quarto 7 teve seu 'disponibilidade' corretamente alterado para 'Indisponível'

  Scenario: alterar o preco da diaria do quarto
    Given estou na pagina de cadastrar 'quartos'
    And preencho os dados do quarto numero 8 tipo 'Quarto Padrão' disponibilidade 'Disponível' preco_diaria '160.0' descricao 'Esse é o quarto de entrada' quantidade_de_hospedes 2 e clico em cadastrar
    And vejo que o quarto 8 foi cadastrado
    When clico para editar o 'preco da diaria' do quarto 8 para '50.0'
    Then vejo que o quarto 8 teve seu 'preco da diaria' corretamente alterado para '50.0'


  Scenario: buscar quartos por disponibilidade
    Given existe ao menos um quarto
    And estou na pagina de quartos
    When seleciono o filtro de busca "Disponibilidade" de quarto
    And seleciono a disponibilidade 'Disponível' na busca
    And clico no botao procurar
    Then vejo todos os quartos que possuem 'Status: Disponível'

  Scenario: buscar quartos por numero
    Given existe ao menos um quarto
    And estou na pagina de quartos
    When seleciono o filtro de busca "Número" de quarto
    And preencho o campo de busca com o numero do quarto
    And clico no botao procurar
    Then vejo todos os quartos que possuem 'Quarto 1'

  Scenario: buscar quartos por tipo
    Given existe ao menos um quarto
    And estou na pagina de quartos
    When seleciono o filtro de busca "Tipo" de quarto
    And seleciono o tipo 'Quarto de Luxo' na busca
    And clico no botao procurar
    Then vejo todos os quartos que possuem 'Quarto de Luxo'

  Scenario: buscar quartos por preco de diaria
    Given existe ao menos um quarto
    And estou na pagina de quartos
    When seleciono o filtro de busca "Preço Diária" de quarto
    And preencho o campo de busca com o preco da diaria
    And clico no botao procurar
    Then vejo todos os quartos que possuem 'Preço da Diária: R$100.0'

  Scenario: buscar quartos por descricao
    Given existe ao menos um quarto
    And estou na pagina de quartos
    When seleciono o filtro de busca "Descrição" de quarto
    And preencho o campo de busca com a descricao do quarto
    And clico no botao procurar
    Then vejo todos os quartos que possuem 'Descrição: Quarto de Luxo'
