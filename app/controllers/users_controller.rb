class UsersController < Devise::RegistrationsController

  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    resource_updated = update_resource(resource, account_update_params)
    yield resource if block_given?
    if resource_updated
      if is_flashing_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
          :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key
        # flash[:notice] =  "Sorry we didn't update your account"
      end
      bypass_sign_in resource, scope: resource_name
      respond_with resource, location: after_update_path_for(resource)
    else
      clean_up_passwords resource
      set_minimum_password_length
      flash[:error] =  "Sorry we didn't update your account. Make sure to put in your current password"
      redirect_to after_update_path_for(resource)
      # respond_with resource, location: after_update_path_for(resource)
    end
  end

  protected

    def after_update_path_for(resource)
      edit_user_registration_path
    end
end
