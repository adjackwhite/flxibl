Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :profiles do
    resources :profile_skills, only: [:create, :update]
    resources :website_links, only: [:create, :update]
    resources :notes, only: [:create, :update]
  end
  resources :profile_skills, only: [:destroy]
  resources :website_links, only: [:destroy]
  resources :notes, only: [:destroy]
end
