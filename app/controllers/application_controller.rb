class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:terms_and_conditions])
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => 'Access Denied!'
  end

end
