Rails.application.routes.draw do
  devise_for :users, path: '/', controllers: {
    sessions: 'user/sessions',
    registrations: 'user/registrations'
  }

  resources :users, path: :u, only: [:show, :edit, :update]

  get 'search', to: 'search#index'
  get 'browse', to: 'browse#index'
  resources :words, path: :w, only: [:index, :show] do
      resources :definitions, path: :def, only: [:show]
  end
  resources :definitions, path: :def, except: [:index, :show] do
    member do
      post :like, to: 'votes#like'
      post :dislike, to: 'votes#dislike'
    end
  end

  root 'words#index'
end
