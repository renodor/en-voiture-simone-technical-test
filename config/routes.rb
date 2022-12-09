Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root 'articles#index'

  resources :potato_prices, only: :index do
    collection do
      get 'best_deal'
    end
  end
end
