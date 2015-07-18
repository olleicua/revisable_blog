class VersionsController < ApplicationController
  before_action :set_user_and_post
  before_action :set_version, only: [:show, :edit, :update, :destroy]

  def show
    @parent = @post.parent
    @comments = @version.comments
  end

  def new
    @version = @post.versions.new
  end

  def create
    @version = @post.versions.new(version_params)
    if @version.save
      flash_success @version
      redirect_to [@user, @post, @version]
    else
      flash_error @version
      render :new
    end
  end

  def destroy
    @version.destroy!
    flash_success @version
    redirect_to [@user, @post]
  end

  private

  def set_user_and_post
    @user = User.ufind(params[:user_username])
    @post = @user.posts.find(params[:post_id])
  end

  def set_version
    @version = @post.versions.find(params[:permalink])
  end

  def version_params
    params.require(:version).permit(:title, :content)
  end
end
