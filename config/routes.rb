Rails.application.routes.draw do
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post '/offers', to: 'users#get_offers'
  post '/booking', to: 'users#make_booking'
end
