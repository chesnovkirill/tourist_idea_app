class UsersController < ApplicationController
    before_action :authenticate_user!
    def user_params
        params.require(:user).permit(:avatar, :first_name, :last_name, :gender, :date_of_birth, :country_of_residence, :city_of_residence, :contact_phone, :education, :work, :interests, :capabilities)
    end
    def show
        redirect_to :root
    end

end
