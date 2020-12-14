class ProfileSkill < ApplicationRecord
  belongs_to :profile
  belongs_to :skill


  validate :max_skills

  def max_skills
    if self.profile.skills.count >= 5
      errors.add(:profile,  "Only add 5 skills")
    end
  end
end
