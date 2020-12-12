class User < ActiveRecord::Base

  belongs_to :room
  has_many :hands
  has_many :cards, through: :hand

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise  :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :confirmable, :lockable, :timeoutable,
          :omniauthable, omniauth_providers: [:facebook, :twitter]

  def self.create_from_provider_data(provider_data)
    byebug
    where(provider: provider_data.provider, uid: provider_data.uid).first_or_create do | user |
    user.email = provider_data.info.email
    user.username = if provider_data.provider == "twitter"
                      provider_data.info.nickname
                    elsif user.email
                      user.email.split('@')[0]
                    end
    user.password = Devise.friendly_token[0, 20]
    user.skip_confirmation!
  end
end
end
