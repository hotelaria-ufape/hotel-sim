Given('Estou na pagina de cadastrar quarto') do
  visit 'quartos/new'
  expect(page).to have_current_path('/quartos/new')
end

When('Eu preencho os dados numero {string} tipo {string} disponibilidade {string} preco_diaria {string} descricao {string} e clico em cadastar') do |numero, tipo, disponibilidade, preco_diaria, descricao|
  fill_in 'quarto[numero]', :with => numero
  fill_in 'quarto[tipo]', :with => tipo
  fill_in 'quarto[disponibilidade]', :with => disponibilidade
  fill_in 'quarto[preco_diaria]', :with => preco_diaria
  fill_in 'quarto[descricao]', :with => descricao
  click_button 'Create Quarto'
end

Then('Vejo que o meu cadastro {string} foi realizado') do |numero|
  expect(page).to have_content(numero)
  expect(page).to have_current_path(quartos_path + '/' + Quarto.last.id.to_s)
end

Given('Estou na pagina de quarto') do
  visit 'quartos'
  expect(page).to have_current_path('/quartos')
end

Given('O quarto de numero {string} tipo {string} disponibilidade {string} preco_diaria {string} descricao {string} existe') do |numero, tipo, disponibilidade, preco_diaria, descricao|
  visit 'quartos/new'
  fill_in 'quarto[numero]', :with => numero
  fill_in 'quarto[tipo]', :with => tipo
  fill_in 'quarto[disponibilidade]', :with => disponibilidade
  fill_in 'quarto[preco_diaria]', :with => preco_diaria
  fill_in 'quarto[descricao]', :with => descricao
  click_button 'Create Quarto'
  expect(page).to have_content(numero)
end

When('Eu clico para remover o quarto de numero {string}') do |numero|
  expect(page).to have_content(numero)
  click_button "Remover quarto"
end

Then('Eu vejo que o quarto com numero {string} foi corretamente removido') do |numero|
  expect(page).to have_no_content(numero)
  expect(page).to have_current_path('/quartos')
end

Given('Estou na tela de quartos disponíveis') do
  visit 'quartos?disponibilidade=true'
  expect(page).to have_current_path('/quartos?disponibilidade=true')
end

Given('O quarto de numero {string} tipo {string} disponibilidade {string} preco_diaria {string} descricao {string} existe') do |numero, tipo, disponibilidade, preco_diaria, descricao|
  visit 'quartos/new'
  fill_in 'quarto[numero]', :with => numero
  fill_in 'quarto[tipo]', :with => tipo
  fill_in 'quarto[disponibilidade]', :with => disponibilidade
  fill_in 'quarto[preco_diaria]', :with => preco_diaria
  fill_in 'quarto[descricao]', :with => descricao
  click_button 'Create Quarto'
  expect(page).to have_content(numero)
end

When('Eu clico para editar o quarto numero {string} para a disponibilidade {string}') do |numero, disponibilidade|
  visit quartos_path(numero)
  expect(page).to have_current_path(quartos_path(numero))
  click_button 'Editar quarto'
  expect(page).to have_current_path(quartos_path(numero) + '/edit')
  fill_in 'quarto[disponibilidade]', :with => disponibilidade
  click_button 'Update Quarto'
  expect(page).to have_current_path(quartos_path(numero))
end

Then('Eu vejo que o quarto com numero {string} foi corretamente alterado para disponibilidade {string}') do |numero, disponibilidade|
  expect(page).to have_content(disponibilidade)
  expect(page).to have_current_path(quartos_path(numero))
end

Given('Estou na tela de quartos indisponíveis') do
  visit 'quartos?disponibilidade=true'
  expect(page).to have_current_path('/quartos?disponibilidade=false')
end

Given('O quarto de numero {string} tipo {string} disponibilidade {string} preco_diaria {string} descricao {string} existe') do |numero, tipo, disponibilidade, preco_diaria, descricao|
  visit 'quartos/new'
  fill_in 'quarto[numero]', :with => numero
  fill_in 'quarto[tipo]', :with => tipo
  fill_in 'quarto[disponibilidade]', :with => disponibilidade
  fill_in 'quarto[preco_diaria]', :with => preco_diaria
  fill_in 'quarto[descricao]', :with => descricao
  click_button 'Create Quarto'
  expect(page).to have_content(numero)
end

When('Eu clico para editar o quarto numero {string} para o preco_diaria {string}') do |numero, preco_diaria|
  visit quartos_path(numero)
  expect(page).to have_current_path(quartos_path(numero))
  click_button 'Editar quarto'
  expect(page).to have_current_path(quartos_path(numero) + '/edit')
  fill_in 'quarto[preco_diaria]', :with => preco_diaria
  click_button 'Update Quarto'
  expect(page).to have_current_path(quartos_path(numero))
end

Then('Eu vejo que o quarto com numero {string} foi corretamente alterado para preco_diaria {string}') do |numero, preco_diaria|
  expect(page).to have_content(preco_diaria)
  expect(page).to have_current_path(quartos_path(numero))
end

Given('Estou na tela de quartos') do
  visit 'quartos'
  expect(page).to have_current_path('/quartos')
end

When('Clico para mostrar os quartos dispoveis') do
  click button 'Exibir quartos disponíveis'
  expect(page).to have_current_path('quartos?disponibilidade=true')
end

Then('Eu vejo que não há quartos com a disponibilidade {string}') do | disponibilidade|
  expect(page).to have_no_content(disponibilidade)
end