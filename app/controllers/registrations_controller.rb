class RegistrationsController < Devise::RegistrationsController
    
    private
    
    def sign_up_params
        params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :date_of_birth, :country_of_residence, :city_of_residence, :contact_phone, :education, :work, :interests, :capabilities)
    end
    
    def account_update_params
        params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password, :date_of_birth, :country_of_residence, :city_of_residence, :contact_phone, :education, :work, :interests, :capabilities)
    end
end