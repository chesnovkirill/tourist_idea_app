class AdventuresController < ApplicationController
    before_action :correct_user, only: [:edit, :update, :destroy]
    before_action :authenticate_user!, only: [:edit, :update, :destroy, :create, :new]
    
    def index
        @search = Adventure.search(params[:q])
        @adventure = Adventure.new
        @adventures = @search.result
        @countries = ISO3166::Country.all
        
    end
    def show
        id = params[:id]
        @adventure = Adventure.find(id)
    end
    def new
        @adventure = Adventure.new
        @adventure.created_at = Time.now
        @countries = ISO3166::Country.all
        # default: render 'new' template
    end
    def create
        params.require(:adventure).permit(:number_of_people,:action_adventure,:country, :city, :description, :details, :adventure_date,:price, :completed)
        format_str = "%m/%d/" + (params[:adventure]["adventure_date"] =~ /\d{4}/ ? "%Y" : "%y")
        date = Date.parse(params[:adventure]["adventure_date"]) rescue Date.strptime(date_str, format_str)
        
        temp={"number_of_people"=>params[:adventure]["number_of_people"], "action_adventure"=>params[:adventure]["action_adventure"], "country"=>params[:adventure]["country"], "city"=>params[:adventure]["city"], "description"=>params[:adventure]["description"], "details"=>params[:adventure]["details"], "adventure_date"=>date, "price"=>params[:adventure]["price"], "completed"=>params[:adventure]["completed"]}
        if !params[:adventure]["city"]
            temp.store("city", "Any City")
        end
        if !params[:adventure]["price"]
            temp["price" => 0]
        end
        @adventure = current_user.adventures.build(temp)
        if current_user.asked_actions
            variable1 = {"asked_actions" => current_user.asked_actions + 1}
        else
            variable1 = {"asked_actions" => 1}
        end
        if current_user.asked_advices
            variable2 = {"asked_advices" => current_user.asked_advices + 1}
        else
            variable2 = {"asked_advices" => 1}
        end
        if params[:adventure]["action_adventure"] == 'action'
            current_user.update_attributes!(variable1)
        else
            current_user.update_attributes!(variable2)
        end
        if current_user.save
            graph = Koala::Facebook::API.new("EAAdFTd7zE9ABACdBQuuNdfVhoBsF5cYdA6PQSvW9OlRmPRhyGRz0EUZA5BpfXZAJRAaZBp9ZCu31FHpjVZCZAnm4WvmqTvP5FxkdYLZAbJU37qxxyQ0Huqu1bqaQGnytgcYzPGAbl1PjMSBj1ZAa4ZBt4kQUVURF2ThJYVG9WJYvxBwZDZD")
            graph.put_object(553202955027429, "feed", {
                         :name => "Test post",
                             :message => "#{@adventure.user.first_name} from #{@adventure.user.city_of_residence} needs an #{@adventure.action_adventure} in #{@adventure.city},  #{@adventure.country} on #{@adventure.adventure_date.strftime("%b, %e %Y")}! #{@adventure.user.first_name} asked: \"#{@adventure.description} \". Eager to pay: $#{@adventure.price} for this #{@adventure.action_adventure}. https://ask-the-locals.herokuapp.com/adventures/ + #{@adventure.id}" 
                         
                         })
        else
            current_user.errors.full_messages
            flash[:notice] = "Unable to create adventure. #{params[:adventure]["action_adventure"]}, #{params[:adventure]["description"]}, #{params[:adventure]["number_of_people"]},  #{params[:adventure]["city"]}"
        end
        redirect_to adventures_path
    end

    def edit
        @countries = ISO3166::Country.all
    end

    def update
        date = Date.new params[:adventure]["adventure_date(1i)"].to_i, params[:adventure]["adventure_date(2i)"].to_i, params[:adventure]["adventure_date(3i)"].to_i
        temp={"number_of_people"=>params[:adventure]["number_of_people"], "action_adventure"=>params[:adventure]["action_adventure"], "country"=>params[:adventure]["country"], "city"=>params[:adventure]["city"], "description"=>params[:adventure]["description"], "details"=>params[:adventure]["details"], "adventure_date"=>date, "price"=>params[:adventure]["price"], "completed"=>params[:adventure]["completed"]}
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
