class AdventuresController < ApplicationController
    before_action :correct_user, only: [:edit, :update, :destroy]
    def index
        @adventure = Adventure.new
        @adventures = Adventure.all
        @countries = ISO3166::Country.all
    end
    def show
        id = params[:id]
        @adventure = Adventure.find(id)
    end
    def new
        @adventure = Adventure.new
        @countries = ISO3166::Country.all
        # default: render 'new' template
    end
    def create
        params.require(:adventure).permit(:number_of_people,:action_adventure,:country,:description,:adventure_date,:price)
        date = Date.new params[:adventure]["adventure_date(1i)"].to_i, params[:adventure]["adventure_date(2i)"].to_i, params[:adventure]["adventure_date(3i)"].to_i
        temp={"number_of_people"=>params[:adventure]["number_of_people"], "action_adventure"=>params[:adventure]["action_adventure"], "country"=>params[:adventure]["country"], "city"=>params[:adventure]["city"], "description"=>params[:adventure]["description"], "details"=>params[:adventure]["details"], "adventure_date"=>date, "price"=>params[:adventure]["price"]}

        @adventure = current_user.adventures.build(temp)
        current_user.save

        flash[:notice] ="#Adventure was successfully created."
        redirect_to adventures_path
    end

    def edit
        @countries = ISO3166::Country.all
    end

    def update
        date = Date.new params[:adventure]["adventure_date(1i)"].to_i, params[:adventure]["adventure_date(2i)"].to_i, params[:adventure]["adventure_date(3i)"].to_i
        temp={"number_of_people"=>params[:adventure]["number_of_people"], "action_adventure"=>params[:adventure]["action_adventure"], "country"=>params[:adventure]["country"], "city"=>params[:adventure]["city"], "description"=>params[:adventure]["description"], "details"=>params[:adventure]["details"], "adventure_date"=>date, "price"=>params[:adventure]["price"]}
        @adventure.update_attributes!(temp)
        flash[:notice] = "Adventure was successfully updated."
        redirect_to adventures_path
    end
    def destroy
        @adventure.destroy
        flash[:notice] = "Adventure deleted."
        redirect_to root_path
    end

    def correct_user
        @adventure = Adventure.find(params[:id])
        if current_user != @adventure.user
            flash[:notice] ="Sorry, you can't change other's adventures"
            redirect_to root_path
        end
    end
end
