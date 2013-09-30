# The restful routes are lazily translated using following the pattern:
#   resources :$deutschername, :as => "$englishname", :controller => "$englishname"
Fsintra::Application.routes.draw do
  resources :benutzer, except: [:destroy, :new, :create], :as => 'users', :controller => 'users' 
  resources :personen, :as => 'people', :controller => 'people' do
    get 'tags/:tag', to: 'people#index', as: :tag, on: :collection
  end
  resources :rechnungen, :as => 'tabs', :controller => 'tabs' do
    get 'offen'  => 'tabs#unpaid', :on => :collection, :as => 'unpaid'
    # get 'ist_bezahlt' => 'tabs#pay', :on => :member, :as => 'is_paid'
    put 'ist_bezahlt' => 'tabs#pay', :on => :member, :as => 'is_paid'
    # FIXME put or post? one of them must be wrong (as rake says...)
    #post 'ist_bezahlt' => 'tabs#pay', :on => :member, :as => 'is_paid'
    put 'als_bezahlt_markieren' => 'tabs#mark_as_paid', :on => :member, :as => 'mark_as_paid'
    # get 'als_bezahlt_markieren' => 'tabs#mark_as_paid', :on => :member, :as => 'mark_as_paid'
  end

# Tally sheet
  get '/tally_sheet' => 'tally_sheets#edit'
  put '/tally_sheet/update' => 'tally_sheets#update'
  post '/tally_sheet/abrechnung' => 'tally_sheets#accounting'
  post '/tally_sheet/accounting' => 'tally_sheets#accounting'
  get '/tally_sheet/edit_list' => 'tally_sheets#edit_list'
  post '/tally_sheet/update_list' => 'tally_sheets#update_list'
  get '/tally_sheet/print_users' => 'tally_sheets#print_users'
  get '/tally_sheet/print_items' => 'tally_sheets#print_items'

# API
  get '/api/items' => 'api#items'
  put '/api/buy' => 'api#buy'

  resources :getraenke, :as => 'beverages', :controller => 'beverages'
  resources :sessions, only: [:new, :create, :destroy]

  get '/login' => 'sessions#new'
  delete '/logout' => 'sessions#destroy'

  resources :protokolle, :as => "minutes", :controller => "minutes" do
    put 'publish', :on => :member
  end

  root :to => 'home#index'
end
