class ApplicationController < ActionController::Base
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_parameter_sanitizer, if: :devise_controller?

  protected
    def after_sign_in_path_for(resource)
      chirps_timeline_path
    end

    def configure_parameter_sanitizer
      devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:signin, :username, :email, :remember_me) }
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :password_confirmation) }
      devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :bio, :email, :first_name, :last_name, :location, :website, :password, :password_confirmation, :current_password) }
    end

  private
    def user_not_authorized
      self.response_body = nil
      flash[:alert] = 'A problem has occured.  Please email Admin if you feel this in error.'
      redirect_to(request.referrer || root_path)
    end
end
