class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  def index
    if user_signed_in?
      @users = User.where.not(id: current_user.id).order("created_at DESC").page(params[:page]).per(9)
    else
      @users = User.order("created_at DESC").page(params[:page]).per(9)
    end
  end

  def followings
    user = User.find(params[:id])
    @users = user.followings
  end

  def followers
    user = User.find(params[:id])
    @users = user.followers
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to users_path, alert: '不正なアクセスです。'
    elsif @user.email == 'guestuser@example.com'
      redirect_to user_path(@user), alert: '不正なアクセスです。'
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'プロフィールを変更しました。'
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :profile, :profile_image)
  end
end
