Feature:
  As a usuario
  I want to criar, editar, remover e visualizar cadastros de quartos
  So that possa manter atualizando o cadastro

  Scenario: cadastrar um quarto
    Given Estou na pagina de cadastrar quarto
    When Eu preencho os dados numero '1' tipo 'Quarto Padrão' disponibilidade 'true' preco_diaria '150.0' descricao 'Esse é o quarto de entrada' e clico em cadastar
    Then Vejo que o meu cadastro '1' foi realizado

  Scenario: remover um quarto
    Given Estou na pagina de quarto
    And O quarto de numero '1' tipo 'Quarto Padrão' disponibilidade 'true' preco_diaria '150.0' descricao 'Esse é o quarto de entrada' existe
    When Eu clico para remover o quarto de numero '1'
    Then Eu vejo que o quarto com numero '1' foi corretamente removido

  Scenario: alterar disponibiliade do quarto
    Given Estou na tela de quartos disponíveis
    And O quarto de numero '2' tipo 'Quarto Padrão' disponibilidade 'true' preco_diaria '150.0' descricao 'Esse é o quarto de entrada' existe
    When Eu clico para editar o quarto numero '2' para a disponibilidade 'false'
    Then Eu vejo que o quarto com numero '2' foi corretamente alterado para disponibilidade 'false'

  Scenario: alterar o preco da diaria do quarto
    Given Estou na tela de quartos indisponíveis
    And O quarto de numero '3' tipo 'Quarto Padrão' disponibilidade 'true' preco_diaria '160.0' descricao 'Esse é o quarto de entrada' existe
    When Eu clico para editar o quarto numero '3' para o preco_diaria '50.0'
    Then Eu vejo que o quarto com numero '3' foi corretamente alterado para preco_diaria '50.0'
    
  Scenario: garantir filtro de disponibilidade
    Given Estou na tela de quartos
    When Clico para mostrar os quartos dispoveis
    Then  Eu vejo que não há quartos com a disponibilidade 'Disponível'