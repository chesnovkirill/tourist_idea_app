class UserMailer < ApplicationMailer
    default from: "twigs.notifications@gmail.com"
    def welcome_email(user)
        @user = user
        @url = 'http://www.google.com'
        mail(to:@user.email, subject: 'You got a New Message on TWIGS')
    end
end
