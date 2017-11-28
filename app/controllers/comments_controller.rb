class CommentsController < ApplicationController
    def create
        @adventure = Adventure.find(params[:adventure_id])
        @comment = @adventure.comments.create(params[:comment].permit(:name, :body, :capabilities, :price, :image))
        @comment.user_id = current_user.id
        @name = @comment.user.first_name
        @comment.save
        redirect_to adventures_path
    end
    def destroy
        @adventure = Adventure.find(params[:adventure_id])
        @comment = @adventure.comments.find(params[:id])
        @comment.destroy
        redirect_to adventures_path
    end
end
