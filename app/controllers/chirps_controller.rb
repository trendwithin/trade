class ChirpsController < ApplicationController
  def new
    @chirp = Chirp.new
  end

  def create
    @chirp = Chirp.new(chirp_params)
    @chirp.user_id = current_user.id
    if @chirp.save
      redirect_to timeline_chirps_path, notice: 'Comment was successfully added.'
    else
      @chirps = Chirp.desc
      render timeline_chirps_path
    end
  end

  def destroy
    @chirp = Chirp.find([:id])
    @chirp.delete
    redirect_to timeline_chirps_path, notice: 'Comment was successfully deleted.'
  end

  def timeline
    @chirp = Chirp.new
    @chirps = Chirp.desc
  end

  private
    def chirp_params
      params.require(:chirp).permit(:content)
    end
end
