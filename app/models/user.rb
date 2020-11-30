class User < ActiveRecord::Base

  belongs_to :room
  has_many :hands
  has_many :cards, through: :hand

  def self.create_user!(usr = {})
    session_token = SecureRandom.base64(10)
    usr['session_token'] = session_token
    @user = User.create!(usr)
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

  def self.find_or_create_from_auth_hash(auth_hash)
    user = where(provider: auth_hash.provider, uid: auth_hash.uid).first_or_create
    user.update(
      username: auth_hash.info.name,
      profile_image: auth_hash.info.image,
      token: auth_hash.credentials.token,
      secret: auth_hash.credentials.secret
    )
    user
  end

end
