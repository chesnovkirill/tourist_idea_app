class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable
  validates_presence_of :first_name, :city_of_residence
  has_many :adventures
  has_many :comments
  has_many :chat_rooms
  has_many :messages
  has_many :friendships, dependent: :destroy
  has_many :users, :through => :friendships
  mount_uploader :avatar, AvatarUploader
  def update_with_password(params, *options)
      current_password = params.delete(:current_password)
      
      if params[:password].blank?
          params.delete(:password)
          params.delete(:password_confirmation) if params[:password_confirmation].blank?
      end
      
      result = if params[:password].blank? || valid_password?(current_password)
      update_attributes(params, *options)
      else
          self.assign_attributes(params, *options)
          self.valid?
          self.errors.add(:current_password, current_password.blank? ? :blank : :invalid)
          false
      end
      clean_up_passwords
      result
    end
end
