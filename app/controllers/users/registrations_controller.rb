class Users::RegistrationsController < Devise::RegistrationsController
  before_action :check_guest, only: %i[update destroy]

  protected

    def after_update_path_for(resource)
      edit_user_registration_path
    end
end
