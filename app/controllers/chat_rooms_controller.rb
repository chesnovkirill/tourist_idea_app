class ChatRoomsController < ApplicationController
    def index
        @chat_rooms = ChatRoom.all
        @my_chat_rooms = ChatRoom.where(host_id: current_user.id).or(ChatRoom.where(user_id: current_user.id))
    end
    
    def create
        @chat_room = current_user.chat_rooms.build(params[:host_name])
        if @chat_room.save
            flash[:success] = 'Chat added!'
            redirect_to @chat_room
            else
            render 'new'
        end
    end
    
    def create_msg
        @user1 = User.find(ChatRoom.find(params[:chat_room_id]).host_id)
        @user2 = User.find(ChatRoom.find(params[:chat_room_id]).user_id)
        msg = ChatRoom.find(params[:chat_room_id]).messages.build(body: params[:message][:body], user: current_user)
        msg.save
        if current_user.id == @user2.id
            UserMailer.welcome_email(@user1, @user2, msg).deliver
            else
            UserMailer.welcome_email(@user2, @user1, msg).deliver
        end
        redirect_to chat_room_path(params[:chat_room_id])
    end
    
    def show
        @chat_room = ChatRoom.includes(:messages).find_by(id: params[:id])
        @message = Message.new
        @user1 = User.find(@chat_room.host_id)
        @user2 = User.find(@chat_room.user_id)
    end
    
    private
    
end
