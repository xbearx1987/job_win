Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => "users/registrations" }

  root 'jobs#index'

  resources :jobs do
    resources :resumes

    member do
      post :add
      post :remove
    end
  end

  namespace :admin do
    resources :jobs do
      member do
        post :publish
        post :hide
      end

      resources :resumes
    end
  end
end
