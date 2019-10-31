class ApplicationController < ActionController::Base
  include ApplicationHelper
  protect_from_forgery with: :exception
  #before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  
  def configure_permitted_parameters
    key = [:name, :username, :password, :password_confirmation, :introduction, :website, :phone_number, :sex, :avatar]
    devise_parameter_sanitizer.permit :account_update, keys: key
    devise_parameter_sanitizer.permit :sign_up, keys: [:name,:username]
  end
end
