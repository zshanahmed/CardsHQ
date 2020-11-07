class UsersController < ApplicationController
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def new
  end




  def create
    reg = /(^[a-zA-z0-9_]+$)/

    blank = user_params[:username].eql?("") || user_params[:password].eql?("") || user_params[:email].eql?("")
    good_format = user_params[:username] =~ reg || user_params[:email] =~ reg  || user_params[:password] =~ reg


    if !good_format || blank ||
      flash[:notice] = "Invalid entry in one of the text-boxes"
    elsif not User.where(:username => user_params[:username]).blank?
      flash[:notice] = "Username, \'#{user_params[:username]}\' has already been taken"
    else
      User.create!(user_params)
    end
    redirect_to request.referrer
  end
end

