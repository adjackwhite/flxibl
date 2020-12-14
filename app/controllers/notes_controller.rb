class NotesController < ApplicationController
before_action :set_profile

  def create
    @note = Note.new(note_params)
    @note.profile = @profile
    @note.save
    redirect_to profile_path(@profile)
  end

  def update
  end

  def destroy
    @note = Note.find(params[:id])
    @note.destroy
    redirect_to profile_path(@profile)
  end

  private

  def note_params
    params.require(:note).permit(:content)
  end

  def set_profile
    @profile = Profile.find(params[:profile_id])
  end
end
