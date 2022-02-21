class Users::RegistrationsController < Devise::RegistrationsController
  before_action :check_guest, only: %i[edit update destroy]

  def after_update_path_for(resource)
    user_path(current_user)
  end
end
