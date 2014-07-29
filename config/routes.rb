# The restful routes are lazily translated using following the pattern:
#   resources :$deutschername, :as => "$englishname", :controller => "$englishname"
Fsintra::Application.routes.draw do

  namespace :minutes do
    resources :motions
  end

  namespace :minutes, :path => 'protokollsystem' do
    resources :minutes, :path => 'protokolle' do
      resources :items, :path => 'tops' do
        resources :motions, :path => 'antrag'
        put 'move', on: :member
      end
      resources :approvements, :path => 'angenommen'
      put 'send_draft', on: :member
      put 'publish', on: :member
    end
    resources :plenum_minutes, :path => 'vv-protokolle', only: [:new, :create, :update, :edit, :show]

    # Exporting
    get 'public' => 'minutes#public'
    get 'public/:id' => 'minutes#public_show', as: 'public_minute'
  end

  resources :benutzer, except: [:destroy, :new, :create], :as => 'users', :controller => 'users'

  resources :personen, :as => 'people', :controller => 'people' do
    get 'edit_tags', to: 'people#edit_tags'
    patch 'update_tags', to: 'people#update_tags'
    get 'tags/:tag', to: 'people#index', as: :tag, on: :collection
  end

  resources :rechnungen, :as => 'tabs', :controller => 'tabs' do
    collection do
      get 'offen'  => 'tabs#unpaid', :as => 'unpaid'
      get 'laufend' => 'tabs#running', :as => 'running'
    end

    member do
      put 'is_paid' => 'tabs#pay'
      get 'detail' => 'tabs#detail'
      post 'add_beverage/:beverage_id' => 'tabs#add_beverage', :as => 'add_beverage'
    end
  end

# Tally sheet
  get '/tally_sheet' => 'tally_sheets#index'
  get '/tally_sheet/edit' => 'tally_sheets#edit'
  post '/tally_sheet/update' => 'tally_sheets#update'
  get '/tally_sheet/print_users' => 'tally_sheets#print_users'
  get '/tally_sheet/print_items' => 'tally_sheets#print_items'
  get '/tally_sheet/print_price_list' => 'tally_sheets#print_price_list'

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
