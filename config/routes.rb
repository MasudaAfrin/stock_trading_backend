Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do
      resources :businesses, only: %i[index create]
      resources :stock_trades, path: '/stock-trades', only: %i[index create] do
        put '/accept/:id'
        put '/reject/:id'
      end
    end
  end
end
