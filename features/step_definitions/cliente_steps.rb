# Generalizando o Passo de Cadastro das Páginas de "cliente","quartos" e "reservas"
Given('estou na pagina de cadastrar {string}') do |entidade|
  visit entidade+'/new'
  expect(page).to have_current_path('/'+entidade+'/new')
end

When('preencho os dados cpf {string} nome {string} email {string} e telefone: {int} e clico em cadastrar') do |cpf, nome, email, telefone|
  fill_in 'cliente[cpf]', :with => cpf
  fill_in 'cliente[nome]', :with => nome
  fill_in 'cliente[email]', :with => email
  fill_in 'cliente[telefone]', :with => telefone
  click_button 'Cadastrar Cliente'
end

Then('vejo que o cliente {string} foi cadastrado') do |nome|
  expect(page).to have_content('Cliente criado com sucesso.')
  expect(page).to have_current_path('/clientes/'+Cliente.find_by_nome(nome).id.to_s)
end

Then('vejo que seu cpf e invalido') do
  expect(page).to have_content('Cpf informado não é valido.')
end

Then('vejo que seu email e invalido') do
  expect(page).to have_content('Email informado não é valido.')
end

# Generalizando o Passo de Acesso às Páginas de "cliente","quartos" e "reservas"
Given('estou na pagina de {string}') do |entidades|
  visit entidades
  expect(page).to have_current_path('/'+entidades)
end

When('clico para remover o cliente {string}') do |nome|
  visit '/clientes/' + Cliente.find_by_nome(nome).id.to_s
  click_button "Remover cliente"
end

Then('vejo que o cliente {string} foi corretamente removido') do |nome|
  expect(page).to have_no_content(nome)
  expect(page).to have_content("Cliente destruído com sucesso")
  expect(page).to have_current_path('/clientes')
end

When('clico para editar o {string} do cliente {string} para {string}') do |atributo,nome,novo_atributo|
  visit '/clientes/'+Cliente.find_by_nome(nome).id.to_s+'/edit'
  fill_in 'cliente['+atributo+']', :with => novo_atributo
  click_button 'Atualizar Cliente'
end

Then('vejo que o cliente {string} teve seu {string} corretamente alterado para {string}') do |nome,atributo,novo_atributo|
  expect(Cliente.find_by_nome(nome).send(atributo)).to have_content(novo_atributo)
end
