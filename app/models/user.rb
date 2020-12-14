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
  # has_many :users, thrUser.ough: :networks

  def generate_profile
     Profile.create(user: self) if !self.manager
  end


  def managers
    User.joins(:networks).where(networks: { profile_id: profile.id })
  end
end
