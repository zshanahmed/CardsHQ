class Room < ActiveRecord::Base
  has_many :users
  before_create :set_invitation_token
  after_commit :notify_pusher, on: [:create, :update]
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

  def notify_pusher
    Pusher.trigger('room', 'new', self.as_json)
  end
end
