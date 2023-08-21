# Adicionando a ação de login como administrador antes de realizar alguma feature
Before('@admin') do
  emailDoAdministrador = 'admin@exemplo.com'
  senhaDoAdministrador = 'senha12345'
  Administrador.create!(email: emailDoAdministrador, password: senhaDoAdministrador)
  visit('/administradors/sign_in')
  fill_in 'administrador[email]', :with => emailDoAdministrador
  fill_in 'administrador[password]', :with => senhaDoAdministrador
  click_button 'Entrar'
end
