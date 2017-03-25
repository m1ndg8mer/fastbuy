class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :initialize_categories

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:terms_and_conditions])
  end

  rescue_from CanCan::AccessDenied do
    redirect_to root_path, :alert => 'Access Denied!'
  end

  rescue_from ActionController::UnknownController, with: -> { render_404  }
  rescue_from ActiveRecord::RecordNotFound,        with: -> { render_404  }

  def render_404
    respond_to do |format|
      format.html { render template: 'errors/not_found', status: 404 }
      format.all { render nothing: true, status: 404 }
    end
  end

  def initialize_categories
    @parents_categories = Category.all.reject { |c| c.parent_id }
  end

end
