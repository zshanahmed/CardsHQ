class UsersController < ApplicationController
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def new
  end

  def create

    if not User.where(:username => user_params[:username]).blank?
      flash[:notice] = "Username, \'#{user_params[:username]}\' has already been taken"

    else
      User.create!(user_params)
      flash[:notice] = "Account with Username \'#{user_params[:username]}\' has been created"
    end
    redirect_to request.referrer
  end
end

