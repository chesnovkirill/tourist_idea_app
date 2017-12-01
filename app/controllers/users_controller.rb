class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :is_friend?, only: [:show]
    def user_params
        params.require(:user).permit(:avatar, :first_name, :last_name, :gender, :date_of_birth, :country_of_residence, :city_of_residence, :contact_phone, :education, :work, :interests, :capabilities)
    end
    def show
        @user = User.find(params[:id])
    end


end
