class CommentsController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized

  def edit
    @blog = Blog.find(params[:blog_id])
    @comment = Comment.find(params[:id])
    authorize @comment
  end

  def create
    @blog = Blog.find(params[:blog_id])
    @comment = @blog.comments.build(comment_params)
    @comment.user_id = current_user.id
    authorize @comment

    if @comment.save
      redirect_to @blog, notice: 'Comment successfully submited'
    else
      render 'blogs/show'
    end
  end

  def update
    @blog = Blog.find(params[:blog_id])
    @comment = Comment.find(params[:id])
    authorize @comment
    if @comment.update(comment_params)
      redirect_to @blog, notice: "Comment successfully updated."
    else
      render 'edit'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    authorize @comment
    @comment.destroy
    redirect_to blogs_path
  end

  def comment_params
    params.require(:comment).permit(:body, :blog_id)
  end
end
