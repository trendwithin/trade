class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: :public_blog
  after_action :verify_authorized
  skip_after_action :verify_authorized, only: :public_blog

  # GET /blogs
  # GET /blogs.json
  def index
    # @blogs = Blog.all
    if current_user.registered?
      @blogs = Blog.posted
    else
      @blogs = Blog.all.desc
    end
    authorize @blogs
  end

  # GET /blogs/1
  # GET /blogs/1.json
  def show
    count = @blog.click_count + 1
    @blog.update_attributes(click_count: count)
    @comment = Comment.new
  end

  # GET /blogs/new
  def new
    @blog = Blog.new
    authorize @blog
  end

  # GET /blogs/1/edit
  def edit
  end

  # POST /blogs
  # POST /blogs.json
  def create
    @blog = current_user.blogs.build(blog_params)
    authorize @blog
    respond_to do |format|
      if @blog.save
        format.html { redirect_to @blog, notice: 'Blog was successfully created.' }
        format.json { render :show, status: :created, location: @blog }
      else
        format.html { render :new }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blogs/1
  # PATCH/PUT /blogs/1.json
  def update
    respond_to do |format|
      if @blog.update(blog_params)
        format.html { redirect_to @blog, notice: 'Blog was successfully updated.' }
        format.json { render :show, status: :ok, location: @blog }
      else
        format.html { render :edit }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blogs/1
  # DELETE /blogs/1.json
  def destroy
    @blog.destroy
    respond_to do |format|
      format.html { redirect_to blogs_url, notice: 'Blog was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def public_blog
    @blogs = Blog.posted.public_blog
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog
      @blog = Blog.find(params[:id])
      authorize @blog
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def blog_params
      params.require(:blog).permit(:title, :body, (:publishes if current_user.role == 'admin'), (:statuses if current_user.role == 'admin'))
    end
end
