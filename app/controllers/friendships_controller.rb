class FriendshipsController < ApplicationController
    def create
        if !current_user.friendships.find_by(:friend_user_id => params[:chat_room][:friend_id])
            @friendship1 = current_user.friendships.build(:friend_user_id => User.find(params[:chat_room][:friend_id]))
            t = User.find(params[:chat_room][:friend_id])
            @friendship2 = t.friendships.build(:friend_user_id => current_user.id)
            @friendship1.save
            @friendship2.save
        end
        
        @adventure = Adventure.find(params[:chat_room][:adventure_id])
        temp = {"completed"=>true}
        if current_user.gave_actions
            variable1 = {"gave_actions" => current_user.gave_actions + 1}
            else
            variable1 = {"gave_actions" => 1}
        end
        if current_user.gave_advices
            variable2 = {"gave_advices" => current_user.gave_advices + 1}
            else
            variable2 = {"gave_advices" => 1}
        end
        if @adventure.action_adventure == 'action'
            current_user.update_attributes!(variable1)
            else
            current_user.update_attributes!(variable2)
        end
        current_user.save
        @adventure.update_attributes!(temp)
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
