Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'user/sessions',
    registrations: 'user/registrations'
  }

  resources :users, only: [:show, :edit, :update]

  get 'search', to: 'search#index'
  get 'browse', to: 'browse#index'
  resources :words, only: [:index, :show]
  resources :definitions, except: [:index] do
    member do
      post :like, to: 'votes#like'
      post :dislike, to: 'votes#dislike'
    end
  end

  root 'words#index'
end
