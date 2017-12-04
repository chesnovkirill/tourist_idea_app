class Adventure < ActiveRecord::Base
    belongs_to :user
    has_many :comments, dependent: :destroy
    validates :description, :presence => true
end
