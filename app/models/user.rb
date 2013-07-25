class User < ActiveRecord::Base
  include MemoryBoxMethods
  include InvitationMethods

  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable, 
         email_regexp: /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i

  has_many :members, dependent: :destroy
  has_many :memory_boxes, through: :members
  
  has_many :sent_invitations, class_name: "Invitation", foreign_key: :sender_id
  has_many :received_invitations, class_name: "Invitation", foreign_key: :receiver_id

  before_save :ensure_authentication_token
  before_save :ensure_pusher_id

  validates :email, :first_name, :last_name, presence: true

  def self.valid_email(email)
    !!email.match(/^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i)
  end

  private

  def ensure_pusher_id
    return if self.pusher_id.present?
    self.pusher_id = loop do
      random_token = SecureRandom.urlsafe_base64
      break random_token unless self.class.where(pusher_id: random_token).exists?
    end
  end

end