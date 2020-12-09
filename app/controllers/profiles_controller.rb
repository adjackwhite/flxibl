class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update]


  def index
    @freelancers = current_user.profiles
    @managers = current_user.managers
  end

  def show
  end

  def new
    @profile = Profile.new
  end

  def create
    @profile = Profile.new(profile_params)
    @user = current_user
    @profile.user = @user
    if @profile.save
      redirect_to edit_profile_path(@profile)
    else
      render :new
    end
  end

  def edit
    @website_link = WebsiteLink.new
    @profile_skill = ProfileSkill.new
  end

  def update
    if @profile.update(profile_params)
      redirect_to profile_path(@profile)
    else
      render :new
    end
  end

  def destroy
  end


  private

  def profile_params
    params.require(:profile).permit(:profession, :bio, :lowest_day_rate, :highest_day_rate, :location)
  end

  def set_profile
    @profile = Profile.find(params[:id])
  end

end
