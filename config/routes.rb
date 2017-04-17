Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'user/sessions',
    registrations: 'user/registrations'
  }

  resources :users, only: [:show, :edit, :update]

  get 'search', to: 'search#index'
  get 'browse', to: 'browse#index'
  resources :words, only: [:index, :show] do
      resources :definitions, only: [:show]
  end
  resources :definitions, except: [:index, :show] do
    member do
      post :like, to: 'votes#like'
      post :dislike, to: 'votes#dislike'
    end
  end

  root 'words#index'
end
