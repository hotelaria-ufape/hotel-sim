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

  @javascript
  @admin
  Scenario: buscar quartos por numero
    Given estou na pagina de cadastrar 'quartos'
    And preencho os dados do quarto numero 8 tipo 'Quarto Padrão' disponibilidade 'Disponível' preco_diaria '160.0' descricao 'Esse é o quarto de entrada' quantidade_de_hospedes 2 e clico em cadastrar
    And vejo que o quarto 8 foi cadastrado
    And estou na pagina de 'quartos'
    When seleciono o filtro de busca 'Número' de quarto
    And preencho o campo de busca de quarto com "8"
    And clico no botao procurar
    Then devo ver todos os quartos com '8' no campo 'Número'

  @javascript
  @admin
  Scenario: buscar quartos por disponibilidade
    Given estou na pagina de cadastrar 'quartos'
    And preencho os dados do quarto numero 8 tipo 'Quarto Padrão' disponibilidade 'Disponível' preco_diaria '160.0' descricao 'Esse é o quarto de entrada' quantidade_de_hospedes 1 e clico em cadastrar
    And vejo que o quarto 8 foi cadastrado
    And estou na pagina de cadastrar 'quartos'
    And preencho os dados do quarto numero 7 tipo 'Quarto de Luxo' disponibilidade 'Indisponivel' preco_diaria '150.0' descricao 'Este quarto tem problemas com chuveiro' quantidade_de_hospedes 2 e clico em cadastrar
    And vejo que o quarto 7 foi cadastrado
    And estou na pagina de 'quartos'
    When seleciono o filtro de busca 'Disponibilidade' de quarto
    And preencho o campo de busca de quarto com 'Disponível'
    And clico no botao procurar
    Then devo ver todos os quartos com 'Disponível' no campo 'Disponibilidade'

  @javascript
  @admin
  Scenario: buscar quartos por tipo
    Given estou na pagina de cadastrar 'quartos'
    And preencho os dados do quarto numero 8 tipo 'Quarto Padrão' disponibilidade 'Disponível' preco_diaria '160.0' descricao 'Esse é o quarto de entrada' quantidade_de_hospedes 1 e clico em cadastrar
    And vejo que o quarto 8 foi cadastrado
    And estou na pagina de cadastrar 'quartos'
    And preencho os dados do quarto numero 7 tipo 'Quarto de Luxo' disponibilidade 'Indisponivel' preco_diaria '150.0' descricao 'Este quarto tem problemas com chuveiro' quantidade_de_hospedes 2 e clico em cadastrar
    And vejo que o quarto 7 foi cadastrado
    And estou na pagina de 'quartos'
    When seleciono o filtro de busca 'Tipo' de quarto
    And preencho o campo de busca de quarto com 'Quarto de Luxo'
    And clico no botao procurar
    Then devo ver todos os quartos com 'Quarto de Luxo' no campo 'Tipo'

  @javascript
  @admin
  Scenario: buscar quartos por preco da diaria
    Given estou na pagina de cadastrar 'quartos'
    And preencho os dados do quarto numero 8 tipo 'Quarto Padrão' disponibilidade 'Disponível' preco_diaria '160.0' descricao 'Esse é o quarto de entrada' quantidade_de_hospedes 1 e clico em cadastrar
    And vejo que o quarto 8 foi cadastrado
    And estou na pagina de cadastrar 'quartos'
    And preencho os dados do quarto numero 7 tipo 'Quarto de Luxo' disponibilidade 'Indisponivel' preco_diaria '150.0' descricao 'Este quarto tem problemas com chuveiro' quantidade_de_hospedes 2 e clico em cadastrar
    And vejo que o quarto 7 foi cadastrado
    And estou na pagina de 'quartos'
    When seleciono o filtro de busca 'Preço Diária' de quarto
    And preencho o campo de busca de quarto com '150'
    And clico no botao procurar
    Then devo ver todos os quartos com '150' no campo 'Preço da Diária'

  @javascript
  @admin
  Scenario: buscar quartos por quantidade de hospedes
    Given estou na pagina de cadastrar 'quartos'
    And preencho os dados do quarto numero 8 tipo 'Quarto Padrão' disponibilidade 'Disponível' preco_diaria '160.0' descricao 'Esse é o quarto de entrada' quantidade_de_hospedes 1 e clico em cadastrar
    And vejo que o quarto 8 foi cadastrado
    And estou na pagina de cadastrar 'quartos'
    And preencho os dados do quarto numero 7 tipo 'Quarto de Luxo' disponibilidade 'Indisponivel' preco_diaria '150.0' descricao 'Este quarto tem problemas com chuveiro' quantidade_de_hospedes 2 e clico em cadastrar
    And vejo que o quarto 7 foi cadastrado
    And estou na pagina de 'quartos'
    When seleciono o filtro de busca 'Quantidade de Hóspedes' de quarto
    And preencho o campo de busca de quarto com '2'
    And clico no botao procurar
    Then devo ver todos os quartos com '2' no campo 'Quantidade de Hóspedes'