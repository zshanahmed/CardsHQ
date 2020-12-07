class RegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  def create
    # add custom create logic here
    super
    @user.username = @user.email.split('@')[0]
    @user.save
  end

  def update
    super
  end
end