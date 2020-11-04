class UsersConroller < ApplicationController
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def create

  end
end
