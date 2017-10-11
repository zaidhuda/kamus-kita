Rails.application.routes.draw do
  default_url_options Rails.application.config.action_mailer.default_url_options

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users, path: '/',
    only: ["sessions", "registrations", "passwords"], 
    controllers: {
      sessions: 'user/sessions',
      registrations: 'user/registrations',
      passwords: 'user/passwords'
    }

  resources :users, path: :u, only: [:show, :edit, :update]

  get 'search', to: 'search#index'
  get 'browse', to: 'browse#index'
  get 'random', to: 'random#index'
  get 'privacy', to: 'legal#privacy'
  get 'tos', to: 'legal#tos'
  get 'remove', to: 'legal#remove'
  get 'help', to: 'legal#help'
  get 'developer', to: 'developer#index'
  get 'api', to: 'developer#api', as: :developer_api
  get 'embed', to: 'developer#embed', as: :developer_embed

  scope :vote, as: :vote do
    get '/', to: 'votes#index'
    post '/like/:id', to: 'votes#like', as: :like
    post '/dislike/:id', to: 'votes#dislike', as: :dislike
    post '/ignore/:id', to: 'votes#ignore', as: :ignore
  end

  resources :words, path: :w, only: [:index, :show] do
    member do
      get :banner_preview, to: 'image#banner'
      get :banner, to: 'image#banner_image'
    end
    resources :definitions, path: :def, only: [:show] do
      member do
        get 'embed', to: 'embed#show'
        get 'embed_settings', to: 'embed#embed_settings'
        scope :image do
          get :full_preview, to: 'image#full'
          get :full, to: 'image#full_image'
        end
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
