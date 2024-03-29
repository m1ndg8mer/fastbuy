Rails.application.routes.draw do
  scope ':locale', locale: /#{ I18n.available_locales.join('|') }/ do
    devise_for :users, :controllers => { :registrations => 'registrations' }

    namespace :admin do
      resources :users do
        collection do
          get :dashboard
          get :manage_categories
          get :manage_products
          get :manage_orders
        end
        member do
          patch :change_role
          patch :block
        end
      end
    end

    resources :orders
    patch 'orders/change_status/:id/:status_id', to: 'orders#change_status', as: :change_status

    resources :categories
    resources :products do
      resources :reviews, only: [:create, :destroy]
    end
    resources :line_items
    resources :carts

    root to: 'static_pages#home'
  end

  get '*path', to: redirect("/#{ I18n.default_locale }/%{path}")
  get '', to: redirect("/#{ I18n.default_locale }")
end
