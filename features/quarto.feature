Feature:
  As a usuario
  I want to criar, editar, remover e visualizar cadastros de quartos
  So that possa manter atualizando o cadastro

  Scenario: cadastrar um quarto
    Given Estou na pagina de cadastrar quarto
    When Eu preencho os dados numero 5 tipo 'Quarto Padrão' disponibilidade 'Disponível' preco_diaria '150.0' descricao 'Esse é o quarto de entrada' quantidade_de_hospedes 1 e clico em cadastrar
    Then Vejo que o cadastro do quarto 5 foi realizado

  Scenario: remover um quarto
    Given Estou na pagina de quartos
    And O quarto de numero 6 tipo 'Quarto Padrão' disponibilidade 'Disponível' preco_diaria '150.0' descricao 'Esse é o quarto de entrada' quantidade_de_hospedes 1 existe
    When Eu clico para remover o quarto
    Then Eu vejo que o quarto com numero 6 foi corretamente removido

  Scenario: alterar disponibilidade do quarto
    Given Estou na pagina de quartos
    And O quarto de numero 7 tipo 'Quarto Padrão' disponibilidade 'Disponível' preco_diaria '150.0' descricao 'Esse é o quarto de entrada' quantidade_de_hospedes 2 existe
    When Eu clico para mudar a disponibilidade do quarto para 'Indisponível'
    Then Eu vejo que o quarto teve sua disponibilidade corretamente alterada para 'Indisponível'

  Scenario: alterar o preco da diaria do quarto
    Given Estou na pagina de quartos
    And O quarto de numero 8 tipo 'Quarto Padrão' disponibilidade 'Disponível' preco_diaria '160.0' descricao 'Esse é o quarto de entrada' quantidade_de_hospedes 2 existe
    When Eu clico para mudar o preco da diaria '50.0'
    Then Eu vejo que o quarto teve o preco da diaria alterado para '50.0'

  Scenario: ver quartos disponiveis
    Given Estou na pagina de quartos
    When Eu clico para exibir os quartos disponiveis
    Then Eu vejo todos os quartos que nao possuem a disponibilidade 'Indisponível'