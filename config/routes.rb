Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => 'registrations' }

  namespace :admin do
    resources :users do
      collection do
        get :dashboard
      end
      member do
        patch :change_role
        patch :block
      end
    end
  end

  resources :categories
  resources :products

  root to: 'static_pages#home'

end
