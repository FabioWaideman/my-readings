Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
<<<<<<< HEAD
  resources :books, only: [:index, :show] do
    resources :reviews, only: %i[new create]
  end

  resources :users, only: [:show]
=======
  resources :books, only: %i[index show]
  resources :users, only: %i[show]
>>>>>>> master
end
