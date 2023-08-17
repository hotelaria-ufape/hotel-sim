Rails.application.routes.draw do
  devise_for :administradors
  resources :reservas do
    collection do
      get 'get_custo'
    end
  end
  resources :quartos
  resources :clientes

  root "pages#home"
end
