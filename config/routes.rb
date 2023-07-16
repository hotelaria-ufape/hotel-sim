Rails.application.routes.draw do
  resources :reservas
  resources :quartos
  resources :clientes

   root "main#home"
end
