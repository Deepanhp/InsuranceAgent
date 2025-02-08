Rails.application.routes.draw do
  root 'pages#home'
  
  get '/about', to: 'pages#about', as: :about
  get '/services', to: 'pages#services', as: :services
  get '/contact', to: 'pages#contact', as: :contact
  post '/contact', to: 'pages#submit_contact'
  get '/testimonials', to: 'pages#testimonials', as: :testimonials
  get '/products', to: 'pages#products', as: :products
  get '/calculators', to: 'pages#calculators', as: :calculators
  post '/calculate_premium', to: 'pages#calculate_premium', as: :calculate_premium

  namespace :admin do
    root 'contacts#index'
    resources :contacts, only: [:index, :show, :update]
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
end
