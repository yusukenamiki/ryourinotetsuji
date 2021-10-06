class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    user_path(current_user)
  end

  def after_sign_up_path_for(resource)
    user_path(current_user)
  end

  def check_guest
    email = resource&.email || params[:user][:email].downcase
    if email == 'guestuser@example.com'
      redirect_to root_path, alert: 'ゲストユーザーの編集・削除はできません。'
    end
  end

  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end
end
