Rails.application.routes.draw do
  devise_for :users, path: '/', controllers: {
    sessions: 'user/sessions',
    registrations: 'user/registrations'
  }

  resources :users, path: :u, only: [:show, :edit, :update]

  get 'sitemap', to: 'sitemap#index'
  get 'search', to: 'search#index'
  get 'browse', to: 'browse#index'
  get 'random', to: 'random#index'

  resources :words, path: :w, only: [:index, :show] do
    resources :definitions, path: :def, only: [:show] do
      member do
        get 'embed', to: 'embed#show'
        get 'embed_settings', to: 'embed#embed_settings'
      end
    end
  end

  resources :definitions, path: :def, except: [:index, :show] do
    member do
      post :like, to: 'definitions#like'
      post :dislike, to: 'definitions#dislike'
    end
  end

  root 'words#index'
end
