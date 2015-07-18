class PostsController < ApplicationController
  before_action :set_user
  before_action :set_post, only: [:show, :destroy]

  def index
    @all_posts = @user.posts
    @original_posts = @user.posts.original
  end

  def show
    redirect_to [@user, @post, @post.latest]
  end

  def new
    @post = @user.posts.new
    @post.versions.build
  end

  def create
    @post = @user.posts.new(post_params)
    if @post.save
      flash_success @post
      redirect_to [@user, @post]
    else
      flash_error @post
      render :new
    end
  end

  def destroy
    @post.destroy!
    flash_success @post
    redirect_to @user
  end

  private

  def set_user
    @user = User.find(params[:user_username])
  end

  def set_post
    @post = @user.posts.find(params[:id])
  end

  def post_params
    params.require(:post).permit(versions_attributes: [:title, :content])
  end
end
