Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: 'users/registrations' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  get "/l/:slug", to: "links#follow", as: "follow_link"

  resources :links do
    member do
      get 'password_form'
      post 'verify_password'

    end
  end

  resources :accesses, only: [] do
    member do
      get 'access_details'
      get 'access_counts'
    end
  end

  root 'home#index'
end
