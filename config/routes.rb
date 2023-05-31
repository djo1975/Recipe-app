Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'recipes#index'

  resources :users, only: [:index]
  resources :recipes, only: %i[index show new create destroy] do
    collection do
      get :public_recipes
      get :missing_food
    end
  end

  resources :foods
  resources :recipe_foods

  # Add any additional routes you need below this line
end
