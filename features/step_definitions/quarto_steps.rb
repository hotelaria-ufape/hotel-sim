# Generalizando a Ação de Adição de um Quarto
When('preencho os dados do quarto numero {int} tipo {string} disponibilidade {string} preco_diaria {string} descricao {string} quantidade_de_hospedes {int} e clico em cadastrar') do |numero, tipo, disponibilidade, preco_diaria, descricao, quantidade_de_hospedes|
  fill_in 'quarto[numero]', :with => numero
  select tipo, from: 'quarto[tipo]'
  select disponibilidade, from: 'quarto[disponibilidade]'
  fill_in 'quarto[preco_diaria]', :with => preco_diaria
  fill_in 'quarto[descricao]', :with => descricao
  fill_in 'quarto[quantidade_de_hospedes]', :with => quantidade_de_hospedes
  click_button 'Cadastrar Quarto'
end

# Generalizando o Resultado de Adição de um Quarto
Then('vejo que o quarto {int} foi cadastrado') do |numero|
  # Aguardando o Resultado no Backend
  expect(page).to have_current_path('/quartos/' + Quarto.find_by_numero(numero).id.to_s)
  # Aguardando o Resultado no Frontend
  expect(page).to have_content('Quarto criado com sucesso.')
end

# Generalizando a Ação de Remoção de um Quarto
When('clico para remover o quarto {int}') do |numero|
  visit '/quartos/' + Quarto.find_by_numero(numero).id.to_s
  click_button "Remover quarto"
end

# Generalizando o Resultado da Remoção de um Quarto
Then('vejo que o quarto {int} foi corretamente removido') do |numero|
  # Aguardando o Resultado no Backend
  expect(Quarto.find_by_numero(numero)).to be_nil
  # Aguardando o Resultado no Frontend
  expect(page).to have_content("Quarto destruído com sucesso.")
end

# Generalizando a Ação de Edição de um Quarto
When('clico para editar o {string} do quarto {int} para {string}') do |atributo,numero,novo_atributo|
  visit '/quartos/'+Quarto.find_by_numero(numero).id.to_s+'/edit'
  if atributo == "quantidade de hospedes"
    atributo = "quantidade_de_hospedes"
  end
  if atributo == "preco da diaria"
    atributo = "preco_diaria"
  end
  if atributo == "disponibilidade" || atributo == "tipo"
    select novo_atributo, from: 'quarto['+atributo+']'
  else
    fill_in 'quarto['+atributo+']', :with => novo_atributo
  end
  click_button 'Atualizar Quarto'
end

# Generalizando o Resultado da Edição de um Quarto
Then('vejo que o quarto {int} teve seu {string} corretamente alterado para {string}') do |numero,atributo,novo_atributo|
  if atributo == "quantidade de hospedes"
    atributo = "quantidade_de_hospedes"
  end
  if atributo == "preco da diaria"
    atributo = "preco_diaria"
  end
  if atributo == "disponibilidade"
    case novo_atributo
    when "Disponível"
      novo_atributo = true
    when "Indisponível"
      novo_atributo = false
    end
  end
  # Aguardando o Resultado no Backend
  expect(Quarto.find_by_numero(numero).send(atributo)).to have_content(novo_atributo)
  # Aguardando o Resultado no Frontend
  expect(page).to have_content("Quarto atualizado com sucesso")
end

# Especificando a Ação de Exibição de Quartos Disponíveis
When('seleciono o filtro de busca {string} de quarto') do |filtro|
  select filtro, from: 'attribute-select'
end

When('clico em procurar') do
  click_button 'Procurar'
end

# Especificando o Resultado de Exibição de Quartos Disponíveis
Then('vejo todos os quartos que nao possuem a disponibilidade {string}') do |disponibilidade|
  # Aguardando o Resultado no Backend
  expect(page).to have_current_path('/quartos?disponibilidade=true')
  # Aguardando o Resultado no Frontend
  expect(page).to have_no_content(disponibilidade)
end

Given('existe ao menos um quarto') do
  @quarto = Quarto.create!(numero: 1, tipo: "Quarto de Luxo", disponibilidade: true, preco_diaria: 100, descricao: "Quarto de Luxo", quantidade_de_hospedes: 2)
end

Given('estou na pagina de quartos') do
  visit '/quartos'
end

When('seleciono o filtro de busca disponibilidade de quarto') do
  select("Disponibilidade", from: "attribute-select")
end

When('seleciono a disponibilidade {string} na busca') do |atributo|
  select("Disponível", from: "search")
end

When('clico no botao procurar') do
  click_button 'Procurar'
end

Then('vejo todos os quartos que possuem {string}') do |mensagem|
  expect(page).to have_content(mensagem)
end

When('preencho o campo de busca com o numero do quarto') do
  fill_in 'search', :with => @quarto.numero
end

When('seleciono o tipo {string} na busca') do |tipo|
  select tipo, from: 'search'
end

When('preencho o campo de busca com o preco da diaria') do
  fill_in 'search', :with => @quarto.preco_diaria
end

When('preencho o campo de busca com a descricao do quarto') do
  fill_in 'search', :with => @quarto.descricao
end

When('preencho o campo de busca com a quantidade de hospedes') do
  fill_in 'search', :with => @quarto.quantidade_de_hospedes
end
