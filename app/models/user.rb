class User < ActiveRecord::Base

  belongs_to :room
  has_many :hands
  has_many :cards, through: :hand

  def self.find_or_create_from_auth_hash(auth_hash)
    user = where(provider: auth_hash.provider, uid: auth_hash.uid).first_or_create
    user.update(
        name: auth_hash.info.nickname,
        profile_image: auth_hash.info.image,
        token: auth_hash.credentials.token,
        secret: auth_hash.credentials.secret
    )
    user
  end

end
