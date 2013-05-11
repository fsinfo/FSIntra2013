# The restful routes are lazily translated using following the pattern:
#   resources :$deutschername, :as => "$englishname", :controller => "$englishname"
Fsintra::Application.routes.draw do
  resources :benutzer, except: [:destroy, :new, :create], :as => 'users', :controller => 'users' 
  resources :personen, except: [:destroy], :as => 'people', :controller => 'people'
	resources :rechnungen, :as => 'tabs', :controller => 'tabs' do
		get 'offen'  => 'tabs#unpaid', :on => :collection
		put 'ist_bezahlt' => 'tabs#pay', :on => :member
	end
  resources :strichliste, :as => 'tally_sheets', :controller => 'tally_sheets', :only => [:new, :create]
  get '/strichliste/edit' => 'tally_sheets#edit_list'
  post '/strichliste/update' => 'tally_sheets#update_list'
  resources :getraenke, :as => 'beverages', :controller => 'beverages', :except => [:destroy]
  resources :sessions, only: [:new, :create, :destroy]
  get '/login' => 'sessions#new'
  delete '/logout' => 'sessions#destroy'

  resources :protokolle, :as => "minutes", :controller => "minutes" do
    put 'publish', :on => :member
  end

  root :to => 'home#index'
end
