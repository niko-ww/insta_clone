Rails.application.routes.draw do
  root 'static_pages#top'

  devise_for :users
  devise_scope :user do
    get    'users/signup', to: 'devise/registrations#new',    as: :new_user
    post   'users/signup', to: 'devise/registrations#create', as: :users
    get    'users/login',  to: 'devise/sessions#new',         as: :new_user_login
    post   'users/login',  to: 'devise/sessions#create',      as: :user_login
    delete 'users/logout', to: 'devise/sessions#destroy',     as: :user_logout
    #get    '/users',       to: 'users#index',                 as: :users
    #get    'users/:id',    to: 'users#show',                  as: :user
  end
end
