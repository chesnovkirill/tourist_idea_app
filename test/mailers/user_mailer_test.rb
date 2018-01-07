require 'test_helper'

class UserMailerTest < ActionMailer::TestCase

    def chatroom_email
        UserMailer.chatroom_email(User.first, User.first)
    end
end


