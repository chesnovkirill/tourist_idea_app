class UserMailer < ApplicationMailer
    default from: "twigs.notifications@gmail.com"
    def welcome_email(user1, user2, message)
        @user1 = user1
        @user2 = user2
        @message = message
        @url = 'http://www.google.com'
        mail(to:@user1.email, subject: 'You got a New Message on TWIGS')
    end
end
