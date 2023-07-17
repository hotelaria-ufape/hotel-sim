Rails.application.routes.draw do
  resources :reservas do
    collection do
      get 'busca_por_data_de_entrada'
      get 'busca_por_periodo'
    end
  end
  resources :quartos
  resources :clientes

   root "main#home"
end
