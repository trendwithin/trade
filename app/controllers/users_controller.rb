class UsersController < ApplicationController

  def my_profile
  end

  def show
    @user = User.find(params[:id])
    @chirps = @user.chirps.desc
  end
end
