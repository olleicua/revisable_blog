class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  def show
    redirect_to [@user, :posts]
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash_success :profile
      redirect_to @user
    else
      flash_error :profile
      render :edit
    end
  end

  private

  def set_user
    @user = User.ufind(params[:username])
  end

  def user_params
    params.require(:user).permit(:blog_name, :description)
  end
end
