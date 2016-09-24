Rails.application.routes.draw do
  resources :histories
  resources :rooms
  resources :users
  root 'sessions#new'
  get 'static_pages/about'

  get 'static_pages/contact'

  get 'sessions/new'

  get 'sessions/create'

  get 'sessions/destroy'

  get 'searchRoom', to: 'rooms#searchRoom'

  get '/login', to: 'sessions#new'

  post '/login', to: 'sessions#create'

  delete '/logout', to: 'sessions#destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
