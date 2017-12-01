class FriendshipsController < ApplicationController
    def create
        @friendship1 = current_user.friendships.build(:friend_id => params[:friend_id])
        @friendship2 = Users.find(params[:friend_id]).friendships.build(:friend_id => current_user.id)
        if @friendship1.save && @friendship2.save
            flash[:notice] = "Added friend."
            redirect_to root_url
            else
            flash[:error] = "Unable to add friend."
            redirect_to root_url
        end
    end
    
    def destroy
        @friendship1 = current_user.friendships.find(params[:id])
        @friendship.destroy
        flash[:notice] = "Removed friendship."
        redirect_to current_user
    end
    
end
