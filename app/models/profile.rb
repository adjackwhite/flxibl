class Profile < ApplicationRecord
  belongs_to :user
  has_many :website_links, dependent: :destroy
  has_many :profile_skills, dependent: :destroy
  has_many :skills, through: :profile_skills
  has_many :networks, dependent: :destroy
end
