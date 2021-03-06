class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :photo
  has_one :profile
  has_many :networks, dependent: :destroy
  has_many :profiles, through: :networks
  after_create :generate_profile
  before_validation :set_freelancer_profile
  after_update :generate_network
  validates :manager, inclusion: { in: [true, false], message: "Please choose one type of profile" }
  # has_many :users, thrUser.ough: :networks

  def generate_profile
     Profile.create(user: self) if !self.manager
  end

  def set_freelancer_profile
    if self.invited_by
      self.manager = false
    end
  end

  def generate_network
    if self.invited_by_id #if the user has been  invited
      Network.find_or_create_by(user_id: self.invited_by_id, profile_id: self.profile.id)
    end
  end

  def managers
    User.joins(:networks).where(networks: { profile_id: profile.id })
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
