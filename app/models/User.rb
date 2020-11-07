class User < ActiveRecord::Base
  def self.create_user!(usr)
    session_token = SecureRandom.base64(10)
    usr['session_token'] = session_token
    @user = User.create!(usr)
  end
  end
