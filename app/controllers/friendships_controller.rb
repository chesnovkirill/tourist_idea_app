class FriendshipsController < ApplicationController
    def create
        @friendship1 = current_user.friendships.build(:friend_user_id => params[:friend_id])
        #t = Users.find(1)
        #@friendship2 = t.friendships.build(:friend_user_id => current_user.id)
        if @friendship1.save && @friendship2.save
            flash[:notice] = "Added friend."
            else
            flash[:error] = "Unable to add friend."
        end
        params.delete :friend_user_id
        redirect_to chat_rooms_path 
    end
    
    def destroy
        @friendship1 = current_user.friendships.find(params[:id])
        @friendship.destroy
        flash[:notice] = "Removed friendship."
        redirect_to current_user
    end
    
end
