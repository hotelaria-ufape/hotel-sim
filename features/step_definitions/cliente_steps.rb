Given('Estou na pagina de cadastrar cliente') do
  visit 'clientes/new'
  expect(page).to have_current_path('/clientes/new')
end

When('Eu preencho os dados cpf {string} nome {string} email {string} e telefone: {int} e clico em cadastrar') do |cpf, nome, email, telefone|
  fill_in 'cliente[cpf]', :with => cpf
  fill_in 'cliente[nome]', :with => nome
  fill_in 'cliente[email]', :with => email
  fill_in 'cliente[telefone]', :with => telefone
  click_button 'Cadastrar Cliente'
end

Then('Vejo que o {string} foi cadastrado') do |nome|
  expect(page).to have_content(nome)
  expect(page).to have_content('Cliente criado com sucesso.')
  expect(page).to have_current_path('/clientes/'+Cliente.last.id.to_s)
end

Given('O cliente de cpf {string} nome {string} email {string} e telefone: {int} existe') do |cpf, nome, email, telefone|
  visit 'clientes/new'
  fill_in 'cliente[cpf]', :with => cpf
  fill_in 'cliente[nome]', :with => nome
  fill_in 'cliente[email]', :with => email
  fill_in 'cliente[telefone]', :with => telefone
  click_button 'Cadastrar Cliente'
  expect(page).to have_content('Cliente criado com sucesso.')
end

Then('Vejo que seu cpf e invalido') do
  expect(page).to have_content('Cpf informado não é valido.')
end

Then('Vejo que seu email e invalido') do
  expect(page).to have_content('Email informado não é valido.')
end

Given('Estou na pagina de clientes') do
  visit 'clientes'
  expect(page).to have_current_path('/clientes')
end

When('Eu clico para remover esse cliente') do
  visit '/clientes/' + Cliente.last.id.to_s
  click_button "Remover cliente"
end

Then('Eu vejo que o {string} foi corretamente removido') do |nome|
  expect(page).to have_no_content(nome)
  expect(page).to have_content("Cliente destruído com sucesso")
  expect(page).to have_current_path('/clientes')
end

When('Eu clico para editar seu telefone para {string}') do |telefone|
  visit '/clientes/'+Cliente.last.id.to_s+'/edit'
  fill_in 'cliente[telefone]', :with => telefone
  click_button 'Atualizar Cliente'
end

Then('Eu vejo que o {string} teve seu telefone corretamente alterado para {string}') do |nome, telefone|
  expect(page).to have_content(nome)
  expect(page).to have_content(telefone)
end
