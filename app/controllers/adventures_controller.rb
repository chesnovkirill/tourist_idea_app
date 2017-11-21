class AdventuresController < ApplicationController
    def index
        @adventures = Adventure.all
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
        params.require(:adventure).permit(:number_of_people,:country,:description,:adventure_date,:price)
        date = Date.new params[:adventure]["adventure_date(1i)"].to_i, params[:adventure]["adventure_date(2i)"].to_i, params[:adventure]["adventure_date(3i)"].to_i
        temp={"number_of_people"=>params[:adventure]["number_of_people"], "country"=>params[:adventure]["country"], "city"=>params[:adventure]["city"], "description"=>params[:adventure]["description"], "details"=>params[:adventure]["details"], "adventure_date"=>date, "price"=>params[:adventure]["price"]}
        @adventure = Adventure.create!(temp)
        flash[:notice] ="#Adventure was successfully created."
        redirect_to adventures_path
    end
    def edit
        @adventure = Adventure.find params[:id]
        @countries = ISO3166::Country.all
    end
    
    def update
        @adventure = Adventure.find params[:id]
        date = Date.new params[:adventure]["adventure_date(1i)"].to_i, params[:adventure]["adventure_date(2i)"].to_i, params[:adventure]["adventure_date(3i)"].to_i
        temp={"number_of_people"=>params[:adventure]["number_of_people"], "country"=>params[:adventure]["country"], "city"=>params[:adventure]["city"], "description"=>params[:adventure]["description"], "details"=>params[:adventure]["details"], "adventure_date"=>date, "price"=>params[:adventure]["price"]}
        @adventure.update_attributes!(temp)
        flash[:notice] = "Adventure was successfully updated."
        redirect_to adventure_path(@adventure)
    end
    def destroy
        @adventure = Adventure.find(params[:id])
        @adventure.destroy
        flash[:notice] = "Adventure deleted."
        redirect_to adventures_path
    end
end
