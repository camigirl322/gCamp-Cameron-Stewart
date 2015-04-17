class AuthenticationController < ApplicationController
  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_back_or(projects_path)
    else
      @sign_in_error = "Username/password combination is invalid"
      render :new
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
  end
end
