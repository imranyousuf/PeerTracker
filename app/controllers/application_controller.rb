class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  rescue_from CanCan::AccessDenied do |exception|
      redirect_to main_app.root_url, :alert => "Access Denied"
  end
  protect_from_forgery with: :exception
end
