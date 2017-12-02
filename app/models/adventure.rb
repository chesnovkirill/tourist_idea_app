class Adventure < ActiveRecord::Base
    belongs_to :user
    has_many :comments
    validates :description, :presence => true
end
