require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  skip_before_action :verify_authenticity_token, unless: -> { request.format.html? }
  respond_to :html, :json, :js
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
    devise_parameter_sanitizer.for(:sign_in) << :name
    devise_parameter_sanitizer.for(:account_update) << :name
  end
  # before_filter :check_auth, if: -> { request.headers['Authorization'] }


  # def check_auth
  #   authenticate_or_request_with_http_basic do |username,password|
  #     resource = User.find_by_email(username)
  #     if resource.valid_password?(password)
  #       sign_in :user, resource
  #     end
  #   end
  # end
end
