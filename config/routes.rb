Fsintra::Application.routes.draw do
  resources :users, except: [:destroy]
  resources :sessions, only: [:new, :create, :destroy]
  get '/login' => 'sessions#new'
  delete '/logout' => 'sessions#destroy'

  root :to => 'users#index'
end
