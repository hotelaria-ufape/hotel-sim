Feature:
  As a administrador
  I want to buscar quartos por cada atributo
  So that possa marcar uma reserva para o quarto certo

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