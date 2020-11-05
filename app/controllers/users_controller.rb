class UsersController < ApplicationController
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def create
    reg = /"^\s+$"/
    p = user_params
    if p[:username].nil? || p[:password].nil? || p[:email].nil?
      flash[:notice] = "Invalid entry in one of the text-boxes"
    elsif p[:username] =~ reg || p[:email] =~ reg  || p[:password] =~ reg
      flash[:notice] = "Invalid entry in one of the text-boxes"
    else
      User.create!(user_params)
      redirect_to login_path
    end
    redirect_to request.referrer
  end
end
