class VotesController < ApplicationController
  before_action :authenticate_user!

  def create
    if blog_id = params[:blog_id]
      @blog = Blog.find(blog_id)
      Vote.first_or_create!(votable_type: 'Blog', votable_id: @blog.id, user_id: current_user.id)
      redirect_to blogs_path
    else
      #
    end
  end

  private
    def vote_params
      params.require(:vote).permit(@blog)
    end
end
