class ProfileSkillsController < ApplicationController
before_action :set_profile, except: :destroy

  def create
    @profile_skill = ProfileSkill.new(profile_skill_params)
    @profile_skill.profile = @profile
    @profile_skill.save
    redirect_to edit_profile_path(@profile, anchor: "skill-form")
  end

  def destroy
    @profile_skill = ProfileSkill.find(params[:id])
    @profile_skill.destroy
    redirect_to edit_profile_path(@profile_skill.profile, anchor: "skill-form")
  end

  private

  def profile_skill_params
    params.require(:profile_skill).permit(:skill_id)
  end

  def set_profile
    @profile = Profile.find(params[:profile_id])
  end
end
