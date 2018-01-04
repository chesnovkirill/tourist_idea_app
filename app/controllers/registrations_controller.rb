class RegistrationsController < Devise::RegistrationsController
    
    private
    
    def sign_up_params
        params.require(:user).permit(:first_name, :email, :password, :password_confirmation, :city_of_residence, :admin, :gave_actions, :gave_advices, :asked_actions, :asked_advices)
    end
    
    def account_update_params
        params.require(:user).permit(:avatar, :first_name, :last_name, :email, :password, :password_confirmation, :current_password, :date_of_birth, :country_of_residence, :city_of_residence, :contact_phone, :education, :work, :interests, :capabilities, :gender,  :gave_actions, :gave_advices, :asked_actions,:asked_advices)
    end

end
