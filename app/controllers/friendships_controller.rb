class FriendshipsController < ApplicationController
    include ActionView::Helpers::NumberHelper
    def create
        if !current_user.friendships.find_by(:friend_user_id => params[:chat_room][:friend_id]) &&
            !current_user.friendships.find_by(:user_id => params[:chat_room][:friend_id]) && !User.find(params[:chat_room][:friend_id]).friendships.find_by(:friend_user_id => current_user.id) && !User.find(params[:chat_room][:friend_id]).friendships.find_by(:user_id => current_user.id)
            @friendship1 = current_user.friendships.build(:friend_user_id => User.find(params[:chat_room][:friend_id]))
            t = User.find(params[:chat_room][:friend_id])
            @friendship2 = t.friendships.build(:friend_user_id => current_user.id)
            @friendship1.save
            @friendship2.save
        end
        
        guide = User.find(params[:chat_room][:friend_id])
        adventure = Adventure.find(params[:chat_room][:adventure_id])
        earned = number_with_precision(0.8 * adventure.price, :precision => 2)
        if params[:chat_room][:method] == "0"
            met = "PayPal"
        else
            met = "offline"
        end
        temp = {"completed"=>true, "conducted_by" => params[:chat_room][:friend_id], "earned" => earned, "method" => met}
        if guide.gave_actions
            variable1 = {"gave_actions" => guide.gave_actions + 1}
            else
            variable1 = {"gave_actions" => 1}
        end
        if guide.gave_advices
            variable2 = {"gave_advices" => guide.gave_advices + 1}
            else
            variable2 = {"gave_advices" => 1}
        end
        if adventure.action_adventure == 'action'
            guide.update_attributes!(variable1)
            else
            guide.update_attributes!(variable2)
        end
        adventure.update_attributes!(temp)
        @chat_room = current_user.chat_rooms.build(user_id: current_user.id, host_id: User.find(params[:chat_room][:friend_id]).id, adventure: params[:chat_room][:adventure_id])
        @chat_room.save
        @user1 = Adventure.find(@chat_room.adventure).user
        @user2 = current_user
        UserMailer.chatroom_email(@user1, @user2).deliver
        params.delete :adventure_id
        params.delete :friend_user_id
        redirect_to chat_room_path(@chat_room.id)
    end
    
    def destroy
        @friendship1 = current_user.friendships.find(params[:id])
        @friendship.destroy
        flash[:notice] = "Removed friendship."
        redirect_to current_user
    end
    
end
