Rails.application.routes.draw do
  get "carts/show"
  get "carts/add"
  get "carts/update"
  get "carts/remove"
  # set default page to the "index" action/methods in home_controller.rb (Rails will recognize this controller as "home" as it follows the naming convention)
  root "home#index"
  resources :products, only: [ :index, :show ]
  resources :categories, only: [ :show ]

  resource :cart, only: [ :show ] do
    post "products/add_to cart/:product_id", to: "carts#add_to_cart", as: "add_to"
    # delete "products/remove_from_cart/:product_id", to: "carts#remove_from_cart", as: "remove_from"
    # patch "update/:product_id", to: "carts#update", as: "update_item"
  end

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
