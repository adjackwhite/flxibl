require 'csv'

class ProfilesController < ApplicationController
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/
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
    if !params[:profile].present? || !params[:profile][:file].present?
      redirect_to import_profiles_path
      flash[:alert] = "No file uploaded"
      return
    end
    path = params[:profile][:file].tempfile.path
    count = 0
    emails = []
    CSV.foreach(path) do |row|
      if row[0].match?(EMAIL_REGEX)
        emails << row[0]
      else
        flash[:alert] = "Oops, it seems like an email was invalid"
        redirect_to import_profiles_path
        return
      end
    end
    emails.each do |email|
      freelancer = User.find_by(email: email)
      if freelancer
        Network.create(user: current_user, profile: freelancer.profile )
      else
        User.invite!({ email: email }, current_user)
      end
      count += 1
    end

    flash[:notice] = "#{count} freelancers have been invited to your network"
    redirect_to profiles_path
  end

  def invite
    unless params[:profile][:email].match?(EMAIL_REGEX)
      redirect_to import_profiles_path
      flash[:alert] = "Oops, it seems like the email is invalid"
      return
    end
      freelancer = User.find_by(email: params[:profile][:email])
      if freelancer
        Network.create(user: current_user, profile: freelancer.profile )
      else
        User.invite!({ email: params[:profile][:email] }, current_user)
      end
      redirect_to profiles_path
      flash[:notice] = "#{params[:profile][:email]} has been invited to your network"
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







