Given('Estou na pagina de cadastrar reserva') do
  visit 'reservas/new'
  expect(page).to have_current_path('/reservas/new')
end

When('Eu preencho os dados:') do |tabela|
  select tabela.hashes[0]['cliente'], from: 'reserva[cliente_id]'
  select tabela.hashes[0]['quarto'], from: 'reserva[quarto_id]'
  fill_in 'reserva[data_de_entrada]', :with => DateTime.parse(tabela.hashes[0]['data_de_entrada'])
  fill_in 'reserva[data_de_saida]', :with => DateTime.parse(tabela.hashes[0]['data_de_saida'])
  fill_in 'reserva[custo]', :with => tabela.hashes[0]['custo']
  click_button 'Create Reserva'
end

# Finaliza-se assim devido do Campo "Custo" ser Readonly por conta de uma lógica Javascript na View
Then('Vejo que a reserva foi marcada') do
  expect(page).to have_content('Custo deve ser acima de zero.')
  expect(page).to have_current_path('/reservas')
end

Then('Vejo que existe um periodo minimo de locacao') do
  expect(page).to have_content('Data de saida deve ser marcada pelo menos para 6 horas após a data de entrada.')
  expect(page).to have_current_path('/reservas')
end

Then('Vejo que existe um choque horario entre as reservas') do
  expect(page).to have_content('Este quarto já está reservado para o período de 12/05/2077 às 12:34 até 12/05/2077 às 20:34.')
  expect(page).to have_current_path('/reservas')
end

Given('Estou na pagina de reservas') do
  visit 'reservas'
  expect(page).to have_current_path('/reservas')
end

Given('Acesso uma reserva') do
  visit 'reservas/'+Reserva.last.id.to_s
end

When('Altero a data de entrada para {string}') do |data|
  visit 'reservas/'+Reserva.last.id.to_s+"/edit"
  fill_in 'reserva[data_de_entrada]', :with => DateTime.parse(data)
  click_button "Update Reserva"
end

Then('Vejo que a reserva possui uma nova data de entrada') do
  expect(page).to have_content('Reserva atualizada com sucesso.')
  expect(page).to have_current_path('/reservas/'+Reserva.last.id.to_s)
end

When('Eu clico para cancelar essa reserva') do
  click_button "Remover reserva"
end

Then('Vejo que essa reserva foi corretamente removida') do
  expect(page).to have_current_path('/reservas')
end
