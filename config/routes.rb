Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => 'registrations' }

  namespace :admin do
    resources :users do
      collection do
        get :dashboard
        get :manage_categories
        get :manage_products
      end
      member do
        patch :change_role
        patch :block
      end
    end
  end

  resources :categories
  resources :products do
    resources :reviews, only: [:create, :destroy]
  end
  resources :line_items
  resources :carts

  root to: 'static_pages#home'

end
