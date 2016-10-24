class RegistrationsController < Devise::RegistrationsController
    protected

  # It allows you to edit user without password
  def update_resource(resource, params)
      resource.update_without_password(params)
  end

  def after_update_path_for(resource)
      account_path(resource)
  end
end
