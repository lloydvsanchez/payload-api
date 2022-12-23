Rails.application.routes.draw do
  root 'reservations#index'

  resources :reservations, only: [:index]
  resources :guests, only: [:index, :show]

  post 'reservation', to: 'reservations#payload'
  get 'reservation/:code', to: 'reservations#show'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
