Rails.application.routes.draw do
  # set default page to the "index" action/methods in home_controller.rb (Rails will recognize this controller as "home" as it follows the naming convention)
  root "home#index"
  resources :products, only: [ :index, :show ]
  resources :categories, only: [ :show ]

  resource :cart, only: [ :show ] do
    # url TO: controller#action AS: helper_method_name
    post "products/add_to_cart/:product_id", to: "carts#add", as: "add_to"
    patch "update/:product_id", to: "carts#update", as: "update"
    delete "products/remove_from_cart/:product_id", to: "carts#remove", as: "remove_from"
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

  # SEARCH INTEGRATED INTO HEADER RATHER THAN SEPARATE PAGE
  get "search" => "search#search_results", as: "search_results"
end
