class User < ActiveRecord::Base

  belongs_to :room
  has_many :hands
  has_many :cards, through: :hand

  def self.create_user!(usr = {})
    session_token = SecureRandom.base64(10)
    usr['session_token'] = session_token
    @user = User.create!(usr)
    return session_token
  end



  def self.valid_entry?(parameters)
    reg = /(^[a-zA-z0-9_@.]+$)/
    valid = true

    parameters.each do |key,entry|
      if entry.blank? || !(entry =~ reg) || (entry.ord % 32) == 0
        valid = false
      end
    end
    return valid
  end

end
