class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  protected
  def authenticate_user!(options={})
      if user_signed_in?
          super(options)
      else
          redirect_to login_path, :notice => 'Please Sign Up First'
      end
  end
  def is_friend?
      @var = current_user.friendships.find_by(:friend_user_id => params[:id]) != nil || User.find(params[:id]).friendships.find_by(:friend_user_id => current_user.id) != nil
  end
  def count_adventures
      adventures =  Array.new
      actions =  Array.new
      current_user.adventures.all do |adventure|
          if adventure.action_adventure == "action"
              actions.push(adventure)
              else
              adventures.push(adventure)
          end
      end
      @numadventures = adventures.length
      @numactions = actions.length
  end
end
