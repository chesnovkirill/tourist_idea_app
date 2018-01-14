class AdventuresController < ApplicationController
    include ActionView::Helpers::NumberHelper
    before_action :correct_user, only: [:destroy]
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
        if params[:adventure]["adventure_date"] != ""
            format_str = "%m/%d/" + (params[:adventure]["adventure_date"] =~ /\d{4}/ ? "%Y" : "%y")
            date = Date.parse(params[:adventure]["adventure_date"]) rescue Date.strptime(date_str, format_str)
            temp={"number_of_people"=>params[:adventure]["number_of_people"], "action_adventure"=>params[:adventure]["action_adventure"], "country"=>params[:adventure]["country"], "city"=>params[:adventure]["city"], "description"=>params[:adventure]["description"], "details"=>params[:adventure]["details"], "adventure_date"=>date, "price"=>number_with_precision(params[:adventure]["price"], :precision => 2), "completed"=>params[:adventure]["completed"], "paid" => false, "state"=>params[:adventure]["state"]}
        else
            temp={"number_of_people"=>params[:adventure]["number_of_people"], "action_adventure"=>params[:adventure]["action_adventure"], "country"=>params[:adventure]["country"], "city"=>params[:adventure]["city"], "description"=>params[:adventure]["description"], "details"=>params[:adventure]["details"], "price"=>number_with_precision(params[:adventure]["price"], :precision => 2), "completed"=>params[:adventure]["completed"], "paid" => false, "state"=>params[:adventure]["state"]}
        end
        if !params[:adventure]["city"]
            temp.store("city", "any location")
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
            if params[:adventure]["adventure_date"] != ""
                graph.put_object(553202955027429, "feed", {
                             :name => "Test post",
                                 :message => "#{@adventure.user.first_name} from #{@adventure.user.city_of_residence}, #{@adventure.user.state} needs an #{@adventure.action_adventure} in #{@adventure.city}, #{@adventure.state}  #{@adventure.country} on #{@adventure.adventure_date.strftime("%b, %e %Y")}! #{@adventure.user.first_name} asked: \"#{@adventure.description} \". Eager to pay: $#{@adventure.price}. Invite a friend who can fulfill #{@adventure.user.first_name}'s TWIG and get $#{@adventure.price * 0.3} as a reward for invitation, or do it yourself for full reward! \n https://ask-the-locals.herokuapp.com/adventures/" + "#{@adventure.id}"
                         
                             })
            else
                graph.put_object(553202955027429, "feed", {
                             :name => "Test post",
                                 :message => "#{@adventure.user.first_name} from #{@adventure.user.city_of_residence}, #{@adventure.user.state} needs an #{@adventure.action_adventure} in #{@adventure.city}, #{@adventure.state}  #{@adventure.country} any time! #{@adventure.user.first_name} asked: \"#{@adventure.description} \". Eager to pay: $#{@adventure.price}. Invite a friend who can fulfill #{@adventure.user.first_name}'s TWIG and get $#{@adventure.price * 0.3} as a reward for invitation, or do it yourself for full reward! \n. https://ask-the-locals.herokuapp.com/adventures/" + "#{@adventure.id}"
                             
                             })
            end
        else
            current_user.errors.full_messages
            flash[:notice] = "Unable to create adventure. #{params[:adventure]["action_adventure"]}, #{params[:adventure]["description"]}, #{params[:adventure]["number_of_people"]},  #{params[:adventure]["city"]}"
        end
        redirect_to adventures_path
    end

    def edit
        @adventure = Adventure.find(params[:id])
        @countries = ISO3166::Country.all
    end
    
    def mytwigs
        @adventures = current_user.adventures + Adventure.where(conducted_by: current_user.id)
    end

    def update
        @adventure = Adventure.find(params[:id])
        if params[:adventure]["inviter"] != "0"
            inviter = params[:adventure]["inviter"]
            earned = number_with_precision(@adventure.price * 0.56, :precision => 2)
        else
            if @adventure.inviter != "N/A"
                inviter = @adventure.inviter
                earned = @adventure.earned
            else
                inviter = "N/A"
                earned = @adventure.earned
            end
        end
        temp={"paid" => params[:adventure][:paid], "earned" => earned, "rating" => params[:adventure][:rating], "inviter" => inviter}
        @adventure.update_attributes!(temp)
        redirect_to mytwigs_adventures_path
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
