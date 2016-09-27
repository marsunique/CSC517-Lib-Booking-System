Rails.application.routes.draw do
  resources :histories
  resources :rooms
  resources :users

  root 'sessions#welcome'

  get 'static_pages/about'

  get 'static_pages/contact'

  get 'sessions/new'

  get 'sessions/create'

  get 'sessions/destroy'

  get 'searchAllRoom', to: 'rooms#searchAllRoom'

  get 'showmine', to: 'histories#showmine'

  #get 'showother', to: 'histories#showother'

  get 'show_user_history', to: 'histories#show_user_history'

  get 'show_room_history', to: 'histories#show_room_history'

  get 'login', to: 'sessions#new'

  post 'login', to: 'sessions#create'

  delete 'logout', to: 'sessions#destroy'

  delete 'switch', to: 'sessions#switch'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
