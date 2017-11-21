class AdventuresController < ApplicationController
    before_action :posted?, only: [:edit, :update, :destroy]

    def posted?
        @adventure = Adventure.find params[:id]
        if @adventure.user != current_user.id
            redirect_to adventures_path
        end
    end

    def index
        @adventures = Adventure.all
    end
    def show
        id = params[:id]
        @adventure = Adventure.find(id)
    end
    def new
        @countries = ISO3166::Country.all
        # default: render 'new' template
    end
    def create
        params.require(:adventure).permit(:number_of_people, :country, :description, :adventure_date, :price, :city, :details)
        @adventure = current_user.adventures.build filter_attributes(params[:adventure])

        flash[:notice] ="#Adventure was successfully created."
        redirect_to adventures_path
    end
    def edit
        @countries = ISO3166::Country.all
    end

    def update
        params.require(:adventure).permit(:number_of_people, :country, :description, :adventure_date, :price, :city, :details)
        @adventure.update_attributes! filter_attributes(params[:adventure])

        flash[:notice] = "Adventure was successfully updated."
        redirect_to adventure_path(@adventure)
    end
    def destroy
        @adventure.destroy
        flash[:notice] = "Adventure deleted."
        redirect_to adventures_path
    end

    def filter_attributes attributes
        date = Date.new attributes["adventure_date(1i)"].to_i, attributes["adventure_date(2i)"].to_i, attributes["adventure_date(3i)"].to_i
        attributes[:adventure_date] = date

        attributes.delete "adventure_date(1i)"
        attributes.delete "adventure_date(2i)"
        attributes.delete "adventure_date(3i)"

        p attributes
        return attributes
    end
end
