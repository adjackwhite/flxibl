Rails.application.routes.draw do
  devise_for :users, controller: { registrations: "registrations" }
  root to: 'pages#home'
  resources :profiles do
    collection do
      get :import
      post :upload_csv
      post :invite
    end
    resources :profile_skills, only: [:create, :update]
    resources :website_links, only: [:create, :update]
    resources :notes, only: [:create, :update, :destroy]
  end
  resources :profile_skills, only: [:destroy]
  resources :website_links, only: [:destroy]
end
