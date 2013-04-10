# The restful routes are lazily translated using following the pattern:
#   resources :$deutschername, :as => "$englishname", :controller => "$englishname"
Fsintra::Application.routes.draw do
  resources :benutzer, except: [:destroy], :as => 'users', :controller => 'users' 
	resources :rechnungen, :as => 'tabs', :controller => 'tabs'
  resources :strichliste, :as => 'tally_sheets', :controller => 'tally_sheets'
  resources :getraenke, :as => 'beverages', :controller => 'beverages'
  resources :sessions, only: [:new, :create, :destroy]
  get '/login' => 'sessions#new'
  delete '/logout' => 'sessions#destroy'

  resources :protokolle, :as => "minutes", :controller => "minutes"

  root :to => 'users#index'
end
