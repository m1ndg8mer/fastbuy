Rails.application.routes.draw do
  get 'categories/index'

  get 'categories/new'

  get 'categories/show'

  get 'categories/create'

  get 'categories/update'

  get 'categories/edit'

  get 'categories/destroy'

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
