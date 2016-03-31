class ChirpsController < ApplicationController
  def timeline
    @chirps = Chirp.desc
  end
end
