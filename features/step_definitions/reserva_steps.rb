Given('Estou na pagina de cadastrar reserva apos cadastrar o cliente {string} e o quarto {int}') do |nomeDoCliente,numeroDoQuarto|
  visit 'quartos/new'
  fill_in 'quarto[numero]', :with => numeroDoQuarto
  select "Quarto Padrão", from: 'quarto[tipo]'
  select "Disponível", from: 'quarto[disponibilidade]'
  fill_in 'quarto[preco_diaria]', :with => "100.00"
  fill_in 'quarto[descricao]', :with => "Nada a dizer sobre."
  fill_in 'quarto[quantidade_de_hospedes]', :with => "2"
  click_button 'Cadastrar Quarto'
  expect(page).to have_content('Quarto criado com sucesso.')

  visit 'clientes/new'
  fill_in 'cliente[cpf]', :with => "027.514.584-08"
  fill_in 'cliente[nome]', :with => nomeDoCliente
  fill_in 'cliente[email]', :with => "clienteA@gmail.com"
  fill_in 'cliente[telefone]', :with => "87988095703"
  click_button 'Cadastrar Cliente'
  expect(page).to have_content('Cliente criado com sucesso.')

  visit 'reservas/new'
  expect(page).to have_current_path('/reservas/new')
end

When('Eu preencho os dados cliente {string} quarto {string} data_de_entrada {string} data_de_saida {string} custo {string}') do |cliente, quarto, data_de_entrada, data_de_saida, custo|
  visit 'reservas/new'
  select cliente, from: 'reserva[cliente_id]'
  select quarto, from: 'reserva[quarto_id]'
  fill_in 'reserva[data_de_entrada]', :with => DateTime.parse(data_de_entrada)
  fill_in 'reserva[data_de_saida]', :with => DateTime.parse(data_de_saida)
  fill_in 'reserva[custo]', :with => custo
  click_button 'Agendar Reserva'
end

Then('Vejo que a reserva foi marcada') do
  expect(page).to have_content('Reserva criada com sucesso.')
  expect(page).to have_current_path('/reservas/'+Reserva.last.id.to_s)
end

Then('Vejo que existe um periodo minimo de locacao') do
  expect(page).to have_content('Data de saida deve ser marcada pelo menos para 6 horas após a data de entrada.')
  expect(page).to have_current_path('/reservas')
end

When('Clico para cancelar essa reserva') do
  click_button "Remover reserva"
end

Then('Vejo que essa reserva foi corretamente removida') do
  expect(page).to have_content("Reserva destruída com sucesso.")
  expect(page).to have_current_path('/reservas')
end

Given('Estou na pagina de cadastrar reserva apos cadastrar o cliente {string} o cliente {string} e o quarto {int}') do |nomeDoCliente1,nomeDoCliente2,numeroDoQuarto|
  visit 'quartos/new'
  fill_in 'quarto[numero]', :with => numeroDoQuarto
  select "Quarto Padrão", from: 'quarto[tipo]'
  select "Disponível", from: 'quarto[disponibilidade]'
  fill_in 'quarto[preco_diaria]', :with => "100.00"
  fill_in 'quarto[descricao]', :with => "Nada a dizer sobre."
  fill_in 'quarto[quantidade_de_hospedes]', :with => "2"
  click_button 'Cadastrar Quarto'
  expect(page).to have_content('Quarto criado com sucesso.')

  visit 'clientes/new'
  fill_in 'cliente[cpf]', :with => "027.514.584-08"
  fill_in 'cliente[nome]', :with => nomeDoCliente1
  fill_in 'cliente[email]', :with => "clienteA@gmail.com"
  fill_in 'cliente[telefone]', :with => "87988095703"
  click_button 'Cadastrar Cliente'
  expect(page).to have_content('Cliente criado com sucesso.')

  visit 'clientes/new'
  fill_in 'cliente[cpf]', :with => "703.765.474-48"
  fill_in 'cliente[nome]', :with => nomeDoCliente2
  fill_in 'cliente[email]', :with => "clienteB@gmail.com"
  fill_in 'cliente[telefone]', :with => "87988095703"
  click_button 'Cadastrar Cliente'
  expect(page).to have_content('Cliente criado com sucesso.')

  visit 'reservas/new'
  expect(page).to have_current_path('/reservas/new')
end

Then('Vejo que existe um choque de horario entre essas reservas') do
  expect(page).to have_content('Este quarto já está reservado para Cliente B pelo período de 10/01/2098 das 04:20 até 11/01/2098 às 04:20.')
  expect(page).to have_current_path('/reservas')
end

When('Estou na pagina de reservas') do
  visit 'reservas'
end

When('Seleciono a data de entrada {string}') do |data_de_entrada|
  fill_in 'start_date', :with => DateTime.parse(data_de_entrada)
end

When('Seleciono a data de saida {string}') do |data_de_saida|
  fill_in 'end_date', :with => DateTime.parse(data_de_saida)
end

When('Clico em filtrar') do
  click_button 'Filtrar'
end

Then('Vejo apenas a reserva do {string} marcada nesse periodo') do |nomeDoCliente|
  expect(page).to have_content(Cliente.find_by_nome(nomeDoCliente).reservas.last.data_de_entrada.strftime('%d/%m/%Y às %H:%M'))
  expect(page).to have_no_content(Cliente.find_by_nome("Cliente B").reservas.last.data_de_entrada.strftime('%d/%m/%Y às %H:%M'))
end

