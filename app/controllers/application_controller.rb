class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_search

  def after_sign_in_path_for(resource)
    user_path(current_user)
  end

  def after_sign_up_path_for(resource)
    user_path(current_user)
  end

  def check_guest
    email = resource&.email || params[:user][:email].downcase
    if email == 'guestuser@example.com'
      if user_signed_in?
        redirect_to user_path(current_user), alert: '不正なアクセスです。'
      else
        redirect_to new_password_path(resource_name), alert: 'メールアドレスは不正な値です。'
      end
    end
  end

  def set_search
    @search = User.ransack(params[:q])
    if user_signed_in?
      @search_users = @search.result.where.not(id: current_user.id).order("created_at DESC").page(params[:page]).per(9)
    else
      @search_users = @search.result.order("created_at DESC").page(params[:page]).per(9)
    end
  end

  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end
end
