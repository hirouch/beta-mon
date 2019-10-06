Rails.application.routes.draw do
  resources :decks
  root 'home#top'
  get 'about', to: 'home#about'
  get "/cards/set", to: "cards#set"
  get "/cards/search", to: "cards#search"
  devise_for :users
  get 'cards/index'
  get 'cards/show'
  post '/create', to: 'cards#create'
  delete "/cards/:id", to:"cards#destroy"
  get "/cards/:id/edit", to: "cards#edit"

  root to: "cards#index"
  get "/new", to:"cards#new"
  patch "/cards/:id", to:"cards#update"

  get "/cards/:id/rankChange", to: "cards#rankChange", as: :cards_rankChange

  get   'users/:id'   =>  'users#show'

  resources :cards do
    post :confirm, action: :confirm_new, on: :new
    post :import, on: :collection
  end
end
