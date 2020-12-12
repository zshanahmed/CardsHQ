module ControllerMacros

  def login_user
    test_user = {email: 'test@test.com', password: '123test123', password_confirmation: '123test123', confirmed_at: Date.today}
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = User.create!(test_user)
      # user.confirm! # or set a confirmed_at inside the factory. Only necessary if you are using the "confirmable" module
      sign_in user
    end
  end
end