require "sidekiq/web" # require the web UI

Rails.application.routes.draw do
  root to: "home#index"

  namespace :admin do
    root to: "home#index"
    resources :photos
    resources :albums
    resources :users
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  # Defines the root path route ("/")
  # root "posts#index"
  mount Sidekiq::Web => "/sidekiq" # access it at http://localhost:3000/sidekiq

  resources :photos, only: [:index, :show, :new, :create]

  devise_for :users, path: 'auth', path_names: {
    sign_up: 'register',
    sign_in: "login", 
    sign_out: "logout",
    
  },
  controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  
  post 'follow/:id', to: 'followings#create', as: 'follow_user'
  delete 'unfollow/:id', to: 'followings#destroy', as: 'unfollow_user'

  resource :profile, controller: "users", except: [:new, :create] do
    member do 
      get '', to: "users#show"
      get :photos, to: 'users#show'
      get :albums, to: 'users#show'
      get :followings, to: 'users#show'
      get :followers, to: 'users#show'
    end
  end

  shallow do
    resources :albums do
      resources :photos
    end

    resources :users, only: [:index, :new, :create, :show] do
      get '', to: 'users#show'
      get 'photos', to: 'users#show'
      get 'albums', to: 'users#show'
      get 'followings', to: 'users#show'
      get 'followers', to: 'users#show'
      resources :photos, except: [:show]
    end
  end

  get 'test', to: "home#test_i18n"
end