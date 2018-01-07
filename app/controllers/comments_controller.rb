class CommentsController < ApplicationController
    def create
        @adventure = Adventure.find(params[:adventure_id])
        @comment = @adventure.comments.create(params[:comment].permit(:name, :body, :capabilities, :price, :image))
        @comment.user_id = current_user.id
        @name = @comment.user.first_name
        @comment.save
        @user1 = @adventure.user
        @user2 = current_user
        UserMailer.comment_email(@user1, @user2, @comment).deliver
        redirect_to adventures_path
    end
    def destroy
        @adventure = Adventure.find(params[:adventure_id])
        @comment = @adventure.comments.find(params[:id])
        @comment.delete
        redirect_to adventures_path
    end
end
