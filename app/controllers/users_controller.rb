class UsersController < ApplicationController
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def new
  end

  def create
    reg = /"^\s+$"/
    p = user_params

    blank = p[:username].eql?("") || p[:password].eql?("") || p[:email].eql?("")
    spaces = p[:username] =~ reg || p[:email] =~ reg  || p[:password] =~ reg

    if blank || spaces
      flash[:notice] = "Invalid entry in one of the text-boxes"
    elsif !User.where(:username => p[:username]).blank?
      flash[:notice] = "Username, \'#{p[:username]}\' has already been taken"
    else
      User.create!(p)
    end
    redirect_to request.referrer
  end
end

