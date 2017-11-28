class Comment < ApplicationRecord
    belongs_to :adventure
    belongs_to :user
    mount_uploaders :image, ImageUploader
    serialize :image, JSON
end
