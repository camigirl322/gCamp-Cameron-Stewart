class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    User.find_by(id: session[:user_id])
  end

  helper_method :current_user

  def authorize
     if current_user.nil?
       store_location
       redirect_to signin_path, notice: "You must sign in"
     end
  end

  # after_filter :store_location

  def store_location
    return unless request.get?
    if (request.path != "/sign-in" &&
        request.path != "/sign-up" &&
        request.path != "/login" &&
        request.path != "/sign-out" &&
        !request.xhr?) # don't store ajax calls
      session[:return_to] = request.fullpath
    end
  end

end
