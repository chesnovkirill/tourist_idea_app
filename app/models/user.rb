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
end
