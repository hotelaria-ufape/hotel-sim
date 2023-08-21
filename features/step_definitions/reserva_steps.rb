Given('estou na pagina de cadastrar reserva apos cadastrar o cliente {string} e o quarto {int}') do |nomeDoCliente,numeroDoQuarto|
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

When('preencho os dados cliente {string} quarto {string} data_de_entrada {string} data_de_saida {string} custo {string}') do |cliente, quarto, data_de_entrada, data_de_saida, custo|
  visit 'reservas/new'
  select cliente, from: 'reserva[cliente_id]'
  select quarto, from: 'reserva[quarto_id]'
  fill_in 'reserva[data_de_entrada]', :with => DateTime.parse(data_de_entrada)
  fill_in 'reserva[data_de_saida]', :with => DateTime.parse(data_de_saida)
  fill_in 'reserva[custo]', :with => custo
  click_button 'Agendar Reserva'
end

Then('vejo que a reserva foi marcada') do
  expect(page).to have_content('Reserva criada com sucesso.')
  expect(page).to have_current_path('/reservas/'+Reserva.last.id.to_s)
end

When('clico para editar o {string} da reserva do {string} para {string}') do |atributo, nomeDoCliente, novoAtributo|
  reservaDoCliente = Reserva.find_by_cliente_id(Cliente.find_by_nome(nomeDoCliente).id).id
  visit '/reservas/'+reservaDoCliente.to_s+'/edit'
  if atributo == "data de entrada"
    diferencaEmMinutos = ((Reserva.find(reservaDoCliente).data_de_saida.to_datetime - DateTime.parse(novoAtributo)) * 24 * 60).to_f
    fill_in 'reserva[data_de_entrada]', :with => DateTime.parse(novoAtributo)
  elsif atributo == "data de saida"
    diferencaEmMinutos = ((DateTime.parse(novoAtributo) - Reserva.find(reservaDoCliente).data_de_entrada.to_datetime) * 24 * 60).to_f
    fill_in 'reserva[data_de_saida]', :with => DateTime.parse(novoAtributo)
  else
    diferencaEmMinutos = ((Reserva.find(reservaDoCliente).data_de_saida.to_datetime - Reserva.find(reservaDoCliente).data_de_entrada.to_datetime) * 24 * 60).to_f
    fill_in 'reserva['+atributo+']', :with => novoAtributo
  end
  valorDoQuarto = Quarto.find(Reserva.find(reservaDoCliente).quarto_id).preco_diaria
  if atributo == "quarto"
    idDoQuarto = novoAtributo.gsub("quarto", "")
    valorDoQuarto = Quarto.find(idDoQuarto).preco_diaria
  end
  custoTotal = (valorDoQuarto / 1440) * diferencaEmMinutos
  novoCusto = format('%.2f', custoTotal)
  fill_in 'reserva[custo]', :with => novoCusto
  click_button 'Atualizar Reserva'
  expect(page).to have_content("Reserva atualizada com sucesso")
end

Then('vejo que a reserva do {string} teve seu {string} corretamente alterado para {string}') do |nomeDoCliente, atributo, novoAtributo|
  # Aguardando o Resultado no Backend
  if atributo == "data de entrada"
    expect(Reserva.find_by_cliente_id(Cliente.find_by_nome(nomeDoCliente).id).send("data_de_entrada")).to have_content(novoAtributo)
  elsif atributo == "data de saida"
    expect(Reserva.find_by_cliente_id(Cliente.find_by_nome(nomeDoCliente).id).send("data_de_saida")).to have_content(novoAtributo)
  else
    expect(Reserva.find_by_cliente_id(Cliente.find_by_nome(nomeDoCliente).id).send(atributo)).to have_content(novoAtributo)
  end
  # Aguardando o Resultado no Frontend
  expect(page).to have_content("Reserva atualizada com sucesso")
end

Then('vejo que existe um periodo minimo de locacao') do
  expect(page).to have_content('Data de saida deve ser marcada pelo menos para 6 horas após a data de entrada.')
  expect(page).to have_current_path('/reservas')
end

When('clico para cancelar essa reserva') do
  click_button "Remover reserva"
end

Then('vejo que essa reserva foi corretamente removida') do
  expect(page).to have_content("Reserva destruída com sucesso.")
  expect(page).to have_current_path('/reservas')
end

Given('estou na pagina de cadastrar reserva apos cadastrar o cliente {string} o cliente {string} e o quarto {int}') do |nomeDoCliente1,nomeDoCliente2,numeroDoQuarto|
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

Then('vejo que existe um choque de horario entre essas reservas') do
  expect(page).to have_content('Este quarto já está reservado para Cliente B pelo período de 10/01/2098 das 04:20 até 11/01/2098 às 04:20.')
  expect(page).to have_current_path('/reservas')
end

When('seleciono o filtro de busca {string} de reserva') do |filtro|
  select filtro, from: 'atributo'
end

When('seleciono a data de entrada {string} na busca') do |data_de_entrada|
  fill_in 'data_inicial', :with => DateTime.parse(data_de_entrada)
end

When('seleciono a data de saida {string} na busca') do |data_de_saida|
  fill_in 'data_final', :with => DateTime.parse(data_de_saida)
end

When('clico em filtrar') do
  click_button 'Filtrar'
end

Then('vejo apenas a reserva do {string} marcada nesse periodo') do |nomeDoCliente|
  expect(page).to have_content(Cliente.find_by_nome(nomeDoCliente).reservas.last.data_de_entrada.strftime('%d/%m/%Y às %H:%M'))
  expect(page).to have_no_content(Cliente.find_by_nome("Cliente B").reservas.last.data_de_entrada.strftime('%d/%m/%Y às %H:%M'))
end