# Generalizando o Acesso ao Cadastro das Páginas de "cliente","quartos" e "reservas"
Given('estou na pagina de cadastrar {string}') do |entidade|
  visit entidade+'/new'
  expect(page).to have_current_path('/'+entidade+'/new')
end

# Generalizando a Ação de Cadastro de um Cliente
When('preencho os dados cpf {string} nome {string} email {string} e telefone: {int} e clico em cadastrar') do |cpf, nome, email, telefone|
  fill_in 'cliente[cpf]', :with => cpf
  fill_in 'cliente[nome]', :with => nome
  fill_in 'cliente[email]', :with => email
  fill_in 'cliente[telefone]', :with => telefone
  click_button 'Cadastrar Cliente'
end

# Generalizando o Resultado Positivo de Cadastro de um Cliente
Then('vejo que o cliente {string} foi cadastrado') do |nome|
  # Aguardando o Resultado no Backend
  expect(page).to have_current_path('/clientes/'+Cliente.find_by_nome(nome).id.to_s)
  # Aguardando o Resultado no Frontend
  expect(page).to have_content('Cliente criado com sucesso.')
end

# Generalizando o Resultado Negativo de Cadastro de um Cliente
Then('vejo que o cliente {string} nao foi cadastrado') do |nome|
  # Aguardando o Resultado no Backend
  expect(Cliente.find_by_nome(nome)).to be_nil
end

Then('vejo que seu cpf e invalido') do
  # Aguardando o Resultado no Frontend
  expect(page).to have_content('Cpf informado não é valido.')
end

Then('vejo que seu email e invalido') do
  # Aguardando o Resultado no Frontend
  expect(page).to have_content('Email informado não é valido.')
end

# Generalizando o Acesso as Listas das Páginas de "cliente","quartos" e "reservas"
Given('estou na pagina de {string}') do |entidades|
  visit entidades
  expect(page).to have_current_path('/'+entidades)
end

# Generalizando a Ação de Remoção de um Cliente
When('clico para remover o cliente {string}') do |nome|
  visit '/clientes/' + Cliente.find_by_nome(nome).id.to_s
  click_button "Remover cliente"
end

# Generalizando o Resultado da Remoção de um Cliente
Then('vejo que o cliente {string} foi corretamente removido') do |nome|
  # Aguardando o Resultado no Backend
  expect(Cliente.find_by_nome(nome)).to be_nil
  # Aguardando o Resultado no Frontend
  expect(page).to have_content("Cliente destruído com sucesso")
end

# Generalizando a Ação de Edição de um Cliente
When('clico para editar o {string} do cliente {string} para {string}') do |atributo,nome,novo_atributo|
  visit '/clientes/'+Cliente.find_by_nome(nome).id.to_s+'/edit'
  fill_in 'cliente['+atributo+']', :with => novo_atributo
  click_button 'Atualizar Cliente'
end

# Generalizando o Resultado da Edição de um Cliente
Then('vejo que o cliente {string} teve seu {string} corretamente alterado para {string}') do |nome,atributo,novo_atributo|
  # Aguardando o Resultado no Backend
  expect(Cliente.find_by_nome(nome).send(atributo)).to have_content(novo_atributo)
  # Aguardando o Resultado no Frontend
  expect(page).to have_content("Cliente atualizado com sucesso")
end

When('seleciono o filtro de busca {string} de cliente') do |filtro|
  select(filtro, from: "attribute")
end

When('preencho o campo de busca com {string}') do |dado|
  fill_in 'search', :with => dado
end

When('clico no botão procurar') do
  click_button 'Procurar'
end

Then('devo ver todos os clientes com {string} no campo {string}') do |dado, campo|
  # Aguardando o Resultado no Frontend
  expect(page).to have_no_content('Nenhum cliente encontrado.')
  expect(page).to have_content(dado)
end