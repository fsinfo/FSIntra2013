# The restful routes are lazily translated using following the pattern:
#   resources :$deutschername, :as => "$englishname", :controller => "$englishname"
Fsintra::Application.routes.draw do
  resources :benutzer, except: [:destroy], :as => 'users', :controller => 'users' 
  resources :personen, except: [:destroy], :as => 'people', :controller => 'people'
	resources :rechnungen, :as => 'tabs', :controller => 'tabs' do
		get 'offen'  => 'tabs#unpaid', :on => :collection
		put 'ist_bezahlt' => 'tabs#set_paid', :on => :member
	end
  resources :strichliste, :as => 'tally_sheets', :controller => 'tally_sheets'
  resources :getraenke, :as => 'beverages', :controller => 'beverages'
  resources :sessions, only: [:new, :create, :destroy]
  get '/login' => 'sessions#new'
  delete '/logout' => 'sessions#destroy'

  resources :protokolle, :as => "minutes", :controller => "minutes"

  root :to => 'users#index'
end
