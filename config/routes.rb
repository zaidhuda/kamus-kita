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
  get 'privacy', to: 'legal#privacy'
  get 'tos', to: 'legal#tos'
  get 'remove', to: 'legal#remove'
  get 'help', to: 'legal#help'

  scope :vote, as: :vote do
    get '/', to: 'votes#index'
    post '/like/:id', to: 'votes#like', as: :like
    post '/dislike/:id', to: 'votes#dislike', as: :dislike
    post '/ignore/:id', to: 'votes#ignore', as: :ignore
  end

  resources :words, path: :w, only: [:index, :show] do
    resources :definitions, path: :def, only: [:show] do
      member do
        get 'embed', to: 'embed#show'
        get 'embed_settings', to: 'embed#embed_settings'
        get :image, to: 'image#show'
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
  resources :words, path: '/', only: [:show]
end
