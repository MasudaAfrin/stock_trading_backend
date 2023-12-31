Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do
      resources :businesses, only: %i[index create show]
      resources :stock_trades, path: '/stock-trades', only: %i[index create] do
        put '/accept' => 'stock_trades#accept'
        put '/reject' => 'stock_trades#reject'
      end
    end
  end
end
