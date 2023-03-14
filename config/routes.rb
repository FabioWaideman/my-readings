Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :books, only: [:index, :show] do
    resources :reviews, only: %i[new create]
    resources :bookmarks, only: %i[create]
  end

  resources :users, only: [:show]
  resources :bookmarks, only: [:destroy, :update]
end
