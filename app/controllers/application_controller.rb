class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :resource_name, :resource, :devise_mapping, :resource_class
  
  def resource_name
      :user
  end
  
  def resource
      @resource ||= User.new
  end
  
  def resource_class
      User
  end
  
  def devise_mapping
      @devise_mapping ||= Devise.mappings[:user]
  end
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
end
