class RegistrationsController < Devise::RegistrationsController
  def after_sign_in_path_for(resource)
    edit_profile_path(resource.profile)
  end
end
