class UserMailer < ActionMailer::Base
  default from: "signup@markspells.com"

  def invitation_confirmation(user, invitor)
    @user = user
    @url = "http://markspells.com/signin"
    @invitor = invitor
    mail(:to => user.email, :subject => "You have been invited to MarkSpells.com")
  end

end
