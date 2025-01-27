Rails.application.routes.draw do
  root 'home#index'

  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'
  resources :users, only: [:create] do
    member do
      get 'posts'
      get 'themes'
      get 'liked_posts'
      get 'liked_themes'
    end
  end

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  resources :posts do
    collection do
      get :new_type
      get :new_reading
      get :new_content
      get :confirm
      delete :discard
    end
  end

  resources :image_posts do
    collection do
      post :confirm
      get :complete
    end
  end

  resources :themes do
    member do
      get :all_posts
    end

    resources :posts do
      collection do
        get :new_type
        get :new_reading
        get :new_content
        get :confirm
      end
    end
  end

  resource :profile, only: [:show, :edit, :update] do
    get 'password', to: 'profiles#edit_password'
    patch 'password', to: 'profiles#update_password'
  end

  resource :registration, only: [] do
    delete 'deactivate', to: 'registrations#deactivate'
  end

  post 'like', to: 'likes#create', as: :like
  delete 'unlike', to: 'likes#destroy', as: :unlike

  get 'about', to: 'pages#about', as: :about
  get 'terms', to: 'pages#terms', as: :terms
  get 'privacy', to: 'pages#privacy', as: :privacy
  get 'contact', to: 'pages#contact', as: :contact
end