class SessionsController < ApplicationController
  
  def create
    @user = User.find_by(email: params[:email])
    
    if !@user.blank? && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:notice] = "Sign in successful"
      redirect_to root_path
    else
      flash.now[:alert] = "Invalid email or password"
      return render 'new'
    end
  end

  def new 
  end

  def destroy
    flash[:notice] = "You have been logged out successfully"
    session[:user_id] = nil
    redirect_to root_path
  end
end