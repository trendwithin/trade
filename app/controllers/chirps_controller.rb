class ChirpsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chirp, only: [:edit, :show, :update, :destroy]
  after_action :verify_authorized

  def new
    @chirp = Chirp.new
    authorize @chirp
  end

  def edit
  end

  def show
  end

  def create
    @chirp = Chirp.new(chirp_params)
    @chirp.user_id = current_user.id
    authorize @chirp
    if @chirp.save
      redirect_to timeline_chirps_path, notice: 'Comment was successfully added.'
    else
      @chirps = Chirp.desc
      render timeline_chirps_path
    end
  end

  def update
    if @chirp.update(chirp_params)
      redirect_to timeline_chirps_path, notice: 'Comment was successfully updated'
    else
      render 'form'
    end
  end

  def destroy
    @chirp.delete
    redirect_to timeline_chirps_path, notice: 'Comment was successfully deleted.'
  end

  def timeline
    @chirp = Chirp.new
    @chirps = Chirp.desc
    authorize @chirp, :index?
    authorize @chirps, :index?
  end

  private

    def set_chirp
      @chirp = Chirp.find(params[:id])
      authorize @chirp
    end

    def chirp_params
      params.require(:chirp).permit(:content)
    end
end
