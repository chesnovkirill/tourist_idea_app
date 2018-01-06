class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :is_friend?, only: [:show]
    def index
        @users = User.all
    end
    def user_params
        params.require(:user).permit(:avatar, :first_name, :last_name, :gender, :date_of_birth, :country_of_residence, :city_of_residence, :contact_phone, :education, :work, :interests, :capabilities, :gave_actions, :gave_advices, :asked_actions,:asked_advices)
    end
    def show
        @user = User.find(params[:id])
    end
    def create
        @user = User.new(params[:user])
        if @user.save
            redirect_to @user
        end
    end


end
