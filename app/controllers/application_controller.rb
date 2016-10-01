class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def index
  end


  protected
    def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :password, :first_name, :last_name, :birthday, :description])
      devise_parameter_sanitizer.permit(:account_update, keys: [:name, :email, :password, :current_password,:first_name, :last_name, :birthday, :description,  :avatar])
  end

end
