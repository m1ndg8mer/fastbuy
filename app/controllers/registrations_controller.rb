class RegistrationsController < Devise::RegistrationsController

  def destroy
    resource.soft_delete
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    set_flash_message :notice, :destroyed if is_flashing_format?
    yield resource if block_given?
    respond_with_navigational(resource){ redirect_to after_sign_out_path_for(resource_name) }
  end

  private

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :email, :phone_number, :address, :city, :password, :password_confirmation)
  end

  protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  def after_update_path_for(resource)
    request.referrer
  end

end