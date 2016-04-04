class Chirps::LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chirp
  def create
    @chirp.likes.where(user_id: current_user.id).first_or_create
    respond_to do |format|
      format.html { redirect_to chirps_timeline_path }
      format.js
    end
  end

  private
    def set_chirp
      @chirp = Chirp.find(params[:chirp_id])
    end
end
