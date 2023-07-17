Rails.application.routes.draw do
  resources :reservas do
    collection do
      get 'get_custo'
    end
  end
  resources :quartos
  resources :clientes

  root "pages#home"
end
