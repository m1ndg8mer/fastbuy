class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :initialize_categories
  before_action :current_cart
  before_filter :set_locale

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:terms_and_conditions])
  end

  rescue_from CanCan::AccessDenied do
    redirect_to root_path, :alert => 'Access Denied!'
  end

  rescue_from ActionController::UnknownController, with: -> { render_404  }
  rescue_from ActiveRecord::RecordNotFound,        with: -> { render_404  }

  def render_404
    redirect_to root_path, :alert => 'Not Found!'
  end

  def initialize_categories
    @parents_categories = Category.all.reject { |c| c.parent_id }
    @parents_categories = @parents_categories.first(9)
  end

  def current_cart
    @cart = Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    cart = Cart.create
    session[:cart_id] = cart.id
    @cart = cart
    @cart
  end

  private

  def set_locale
    I18n.locale = params[:locale] if params[:locale].present?
  end

  def default_url_options(options = {})
    { locale: I18n.locale }
  end

end
