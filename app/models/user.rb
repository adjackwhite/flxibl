class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :photo
  has_one :profile
  has_many :networks, dependent: :destroy
  has_many :profiles, through: :networks
  # has_many :users, through: :networks

  def managers
    User.joins(:networks).where(networks: { profile_id: profile.id })
  end
end
