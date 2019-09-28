Rails.application.routes.draw do
  # devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :deck
  # get 'deck/new'
  # get 'deck/create', to: "deck/create"
  # get 'deck/index'
  # get 'deck/destroy'
  # get 'deck/show'
  # get 'deck/edit'
  # get 'deck/update'
  get "/" => "home#top"
  get "about" => "home#about"
  # get 'home/top'
  get "/cards/test", to: "cards#test"
  get "/cards/search", to: "cards#search"
  devise_for :users
  get 'cards/index'
  get 'cards/show'
  post '/create', to: 'cards#create'
  delete "/cards/:id", to:"cards#destroy"
  get "/cards/:id/edit", to: "cards#edit"
  get 'tweets' => 'tweets#index'

  root to: "cards#index"
  get "/new", to:"cards#new"
  patch "/cards/:id", to:"cards#update"



  get "/cards/:id/rankChange", to: "cards#rankChange", as: :cards_rankChange


  # get "/posts/:id/rankupmax", to: "posts#rankupmax", as: :posts_rankmax
  # get '/posts/:id/rankup', to: 'posts#rankup', as: :posts_rankup
  # get "/posts/:id/rankdown", to: "posts#rankdown", as: :posts_rankdown


  get   'users/:id'   =>  'users#show'


  resources :cards do
    post :confirm, action: :confirm_new, on: :new
    post :import, on: :collection
  end
end
