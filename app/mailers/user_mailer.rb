class UserMailer < ActionMailer::Base
  default from: "dayan.naurki@gmail.com"

   def welcome_email(user,url)
    @user = user
    @url  = "#{url}/activation/#{user.user_id}/#{user.access_token}"
    mail(to: @user.user_email, subject: 'Welcome to shoping cart')
  end


end
