Rails.application.routes.draw do
  resources :reservas do
    collection do
      get 'get_custo'
    end
  end
  resources :quartos
  resources :clientes
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
