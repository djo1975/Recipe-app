Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'recipes#public_recipes'

  resources :users, only: [:index]
  resources :recipes, only: %i[index show new create destroy update] do
    collection do
      get :public_recipes
      get :missing_food
    end
    resources :recipe_foods, only: %i[new create destroy]
  end

  resources :foods, only: %i[index show new create destroy]

  # Add any additional routes you need below this line
end
