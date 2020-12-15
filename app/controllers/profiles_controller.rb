require 'csv'

class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update]

  def index
    if current_user.manager?
      @freelancers = current_user.profiles
      @freelancers = @freelancers.profile_search(params[:query]) if params[:query].present?
      @freelancers = @freelancers.profession_search(params[:profession]) if params[:profession].present?
      @freelancers = @freelancers.skill_search(params[:skill]) if params[:skill].present?
      @freelancers = @freelancers.location_search(params[:location]) if params[:location].present?
    else
      @managers = current_user.managers
    end
  end

  def import
  end

  def upload_csv
    path = params[:profile][:file].tempfile.path
    count = 0
    CSV.foreach(path) do |row|
    freelancer = User.find_by(email: row[0])
      if freelancer
        Network.create(user: current_user, profile: freelancer.profile )
      else
        User.invite!({ email: row[0] }, current_user)
      end
      count += 1
    end
    redirect_to profiles_path
    flash[:notice] = "#{count} freelancers have been invited to your network"
  end

  def invite
      freelancer = User.find_by(email: params[:profile][:email])
      if freelancer
        Network.create(user: current_user, profile: freelancer.profile )
      else
        User.invite!({ email: params[:profile][:email] }, current_user)
      end
      if freelancer
        redirect_to profiles_path
        flash[:notice] = "#{params[:profile][:email]} has been invited to your network"
      end
  end

  def show
    @website_links = @profile.website_links
    @note = Note.new
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
    if @profile.user.update(user_params) && @profile.update(profile_params)
      redirect_to profile_path(@profile)
    else
      render :new
    end
  end

  def destroy
  end

  private

  def profile_params
    params.require(:profile).permit(:profession, :bio, :location, :photo)
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name)
  end

  def set_profile
    @profile = Profile.find(params[:id])
  end

end
