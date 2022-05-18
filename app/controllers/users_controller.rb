class UsersController < ApplicationController

  def teacher_sign_up
    @user = User.new()
  end

  def student_sign_up
    @user = User.new()
  end

  def create
    @user = User.new(create_params.merge!(role: params[:role]))
  
    unless create_params[:roll_no].blank?
      user = User.find_by(roll_no: create_params[:roll_no], role: 'student')
      unless user.blank?
        flash[:alert] = "This Roll number has already been taken"
        return render 'student_sign_up'
      end
    end

    if @user.save
      flash[:notice] = "Sign up successful"
      redirect_to root_path
    elsif params[:role] == "student"
      puts "student"
      render 'student_sign_up'
    else
      puts "teacher"
      render 'teacher_sign_up'
    end
  end

  private

  def create_params
    params.require(:user).permit(:full_name, :roll_no, :email, :password, :password_confirmation, :institution, :role)
  end
end
