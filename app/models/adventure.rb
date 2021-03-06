class Adventure < ActiveRecord::Base
    belongs_to :user
    has_many :comments
    validates :action_adventure, :description, :number_of_people, :city, presence: true
end
