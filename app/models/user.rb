class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable
  has_many :adventures, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :chat_rooms, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :friendships, dependent: :destroy
  has_many :users, :through => :friendships
  mount_uploader :avatar, AvatarUploader
  
end
