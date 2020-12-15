class Network < ApplicationRecord
  belongs_to :user
  belongs_to :profile
  validates :profile, uniqueness: { scope: :user }
end
