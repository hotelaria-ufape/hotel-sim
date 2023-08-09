Rails.application.routes.draw do
  resources :reservas do
    collection do
      get 'get_custo'
    end
  end
  resources :quartos do
    member do
      get 'historico_hospedagem', to: 'quartos#historico_hospedagem'
    end
  end
  resources :clientes do
    member do
      get 'historico', to: 'clientes#historico'
    end
  end


  root "pages#home"
end
