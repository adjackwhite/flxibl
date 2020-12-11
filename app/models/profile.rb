class Profile < ApplicationRecord
  include PgSearch::Model
  belongs_to :user
  has_many :website_links, dependent: :destroy
  has_many :profile_skills, dependent: :destroy
  has_many :skills, through: :profile_skills
  has_many :networks, dependent: :destroy
  has_one_attached :photo
  pg_search_scope :profile_search,
    against: [ :profession, :location ],
    associated_against: {
      user: [ :first_name, :last_name, :email, :whatsapp_number ],
      skills: [ :skill ]
    },
    using: {
      tsearch: { prefix: true }
    }
  pg_search_scope :profession_search,
    against: [ :profession ],
    using: {
      tsearch: { prefix: true }
    }
  pg_search_scope :skill_search,
    associated_against: {
      skills: [ :skill ]
    },
    using: {
      tsearch: { prefix: true }
    }
  pg_search_scope :location_search,
    against: [ :location ],
    using: {
      tsearch: { prefix: true }
    }

end
