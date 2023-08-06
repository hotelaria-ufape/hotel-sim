Given('Estou na pagina de cadastrar quarto') do
  visit 'quartos/new'
  expect(page).to have_current_path('/quartos/new')
end

When('Eu preencho os dados numero {int} tipo {string} disponibilidade {string} preco_diaria {string} descricao {string} quantidade_de_hospedes {int} e clico em cadastrar') do |numero, tipo, disponibilidade, preco_diaria, descricao, quantidade_de_hospedes|
  fill_in 'quarto[numero]', :with => numero
  select tipo, from: 'quarto[tipo]'
  select disponibilidade, from: 'quarto[disponibilidade]'
  fill_in 'quarto[preco_diaria]', :with => preco_diaria
  fill_in 'quarto[descricao]', :with => descricao
  fill_in 'quarto[quantidade_de_hospedes]', :with => quantidade_de_hospedes
  click_button 'Cadastrar Quarto'
end

Then('Vejo que o cadastro do quarto {int} foi realizado') do |numero|
  expect(page).to have_content(numero)
  expect(page).to have_content('Quarto criado com sucesso.')
  expect(page).to have_current_path('/quartos/' + Quarto.last.id.to_s)
end

Given('Estou na pagina de quartos') do
  visit 'quartos'
end

Given('O quarto de numero {int} tipo {string} disponibilidade {string} preco_diaria {string} descricao {string} quantidade_de_hospedes {int} existe') do |numero, tipo, disponibilidade, preco_diaria, descricao, quantidade_de_hospedes|
  visit 'quartos/new'
  fill_in 'quarto[numero]', :with => numero
  select tipo, from: 'quarto[tipo]'
  select disponibilidade, from: 'quarto[disponibilidade]'
  fill_in 'quarto[preco_diaria]', :with => preco_diaria
  fill_in 'quarto[descricao]', :with => descricao
  fill_in 'quarto[quantidade_de_hospedes]', :with => quantidade_de_hospedes
  click_button 'Cadastrar Quarto'
  expect(page).to have_current_path('/quartos/' + Quarto.last.id.to_s)
end

When('Eu clico para remover o quarto') do
  click_button "Remover quarto"
end

Then('Eu vejo que o quarto com numero {int} foi corretamente removido') do |numero|
  expect(page).to have_no_content(numero)
  expect(page).to have_content("Quarto destruído com sucesso.")
  expect(page).to have_current_path('/quartos')
end

When('Eu clico para mudar a disponibilidade do quarto para {string}') do |disponibilidade|
  click_link 'Editar quarto'
  select disponibilidade, from: 'quarto[disponibilidade]'
  click_button 'Atualizar Quarto'
end

Then('Eu vejo que o quarto teve sua disponibilidade corretamente alterada para {string}') do |disponibilidade|
  expect(page).to have_content(disponibilidade)
  expect(page).to have_content('Quarto atualizado com sucesso.')
  expect(page).to have_current_path('/quartos/' + Quarto.last.id.to_s)
end

When('Eu clico para mudar o preco da diaria {string}') do |preco_diaria|
  click_link "Editar quarto"
  fill_in 'quarto[preco_diaria]', :with => preco_diaria
  click_button 'Atualizar Quarto'
end

Then('Eu vejo que o quarto teve o preco da diaria alterado para {string}') do |preco_diaria|
  expect(page).to have_content(preco_diaria)
  expect(page).to have_content('Quarto atualizado com sucesso.')
  expect(page).to have_current_path('/quartos/' + Quarto.last.id.to_s)
end

When('Eu clico para exibir os quartos disponiveis') do
  click_link 'Exibir quartos disponíveis'
  expect(page).to have_current_path('/quartos?disponibilidade=true')
end

Then('Eu vejo todos os quartos que nao possuem a disponibilidade {string}') do |disponibilidade|
  expect(page).to have_no_content(disponibilidade)
end