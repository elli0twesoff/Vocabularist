class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authenticated?
    !current_user || !current_user.admin?
  end

  def verify_admin
    unless current_user && current_user.admin 
      redirect_to root_path, flash: { alert: "Access denied, bitch." }
    end
  end
end
