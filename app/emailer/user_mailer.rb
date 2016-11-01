class UserMailer < ApplicationMailer

  default from: "beijingjiuku@yeah.net"

  def signup_confirmation(user)

    @user = user
    @url  = "http://localhost:3000/userinfos/email_active/"+@user.confirmation_token
    #@url = "http://10.99.99.138:3000/userinfos/email_active"
    mail to: user.email, subject: "Sign Up Confirmation"
  end

end
