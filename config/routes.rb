Rails.application.routes.draw do
  root 'static_pages#top'

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: "users/registrations",
    sessions: "users/sessions",
    passwords: "users/passwords"
  }
  devise_scope :user do
    get    'users/signup', to: 'devise/registrations#new',    as: :new_user
    post   'users/signup', to: 'devise/registrations#create', as: :user_signup
    get    'users/login',  to: 'devise/sessions#new',         as: :new_user_login
    post   'users/login',  to: 'devise/sessions#create',      as: :user_login
    delete 'users/logout', to: 'devise/sessions#destroy',     as: :user_logout
    get    '/users',       to: 'users#index',                 as: :users
    get    'users/:id',    to: 'users#show',                  as: :user
    get    'users/:id/edit_password', to: 'users#edit_password',    as: :edit_password_user
    patch  'users/:id',               to: 'users#update_password',  as: :update_password_user
    get    'users/:id/following',    to: 'users#following',   as: :following_user
    get    'users/:id/followers',    to: 'users#followers',   as: :followers_user
  end

  resources :posts,           only:[:show, :new, :create, :destroy] do
    resources :comments,        only:[:create]
  end
  resources :relationships,   only:[:create, :destroy]
end
