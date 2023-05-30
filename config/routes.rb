Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "recipes#index"

  resources :users, only: [:index]
  resources :recipes, only: [:index]
  resources :foods
  resources :recipe_foods

  # Add any additional routes you need below this line
end
