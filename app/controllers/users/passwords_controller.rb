class Users::PasswordsController < Devise::PasswordsController
  before_action :check_guest, only: :create

  def after_sending_reset_password_instructions_path_for(resource)
    new_password_path(resource_name)
  end
end
