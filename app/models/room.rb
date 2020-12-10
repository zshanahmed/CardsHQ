class Room < ActiveRecord::Base
  has_many :users
  before_create :set_invitation_token
  def index; end

  def set_invitation_token
    self.invitation_token = generate_token
  end

  def generate_token
    loop do
      token = SecureRandom.hex(10)
      break token unless Room.where(invitation_token: token).exists?
    end
  end

end
