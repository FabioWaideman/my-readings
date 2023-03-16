Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  root to: "pages#home"
  get '/sign_in', to: 'sessions#new'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :books, only: [:index, :show] do

    resources :bookmarks, only: %i[create]
    resources :reviews, only: [:new, :create, :destroy, :index]

  end

  resources :users, only: [:show] do
    resources :friendships, only: [:create, :destroy]
  end
  resources :bookmarks, only: [:destroy, :update]
end
