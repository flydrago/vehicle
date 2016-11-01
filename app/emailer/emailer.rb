class Emailer < ActionMailer::Base

  default from: 'beijingjiuku@yeah.net'

  def contact(recipient, subject, message)

    mail(:to=>recipient, :subject=>subject) do |format|

      format.html { render :text => message }

    end

  end

end