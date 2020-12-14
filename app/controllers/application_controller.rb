class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:manager])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :whatsapp_number, :photo])
  end

  def after_sign_in_path_for(user)
    if user.first_name.nil?
      edit_profile_path
    else
      stored_location_for(user) || profiles_path
    end
  end

  def after_accept_path_for(resource)
    edit_profile_path(resource.profile)
  end
end
