class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  def is_friend?
      @var = current_user.friendships.find_by(:friend_user_id => params[:id]) != nil
  end
end
