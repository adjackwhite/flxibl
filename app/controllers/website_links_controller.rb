class WebsiteLinksController < ApplicationController
before_action :set_profile, except: :destroy

  def create
    @website_link = WebsiteLink.new(website_params)
    @website_link.profile = @profile
    @website_link.save
    redirect_to edit_profile_path(@profile, anchor: "link-form")
  end

  def destroy
    @website_link = WebsiteLink.find(params[:id])
    @website_link.destroy
    redirect_to edit_profile_path(@website_link.profile, anchor: "link-form")
  end

  private

  def website_params
    params.require(:website_link).permit(:url, :label)
  end

  def set_profile
    @profile = Profile.find(params[:profile_id])
  end
end
