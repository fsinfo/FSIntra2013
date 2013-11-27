class MinuteMailer < ActionMailer::Base
  default from: 'm_hoffmann09@cs.uni-kl.de'
  default to: 'm_hoffmann09@cs.uni-kl.de'
  default sender: 'm_hoffmann09@cs.uni-kl.de'

  def send_draft minute, user
    @minutes_minute = minute
    mail(from: get_email_with_name(user), subject: "Protokoll der FSR-Sitzung vom #{l @minutes_minute.date} [ENTWURF]")
  end

  private
  
  def get_email_with_name(user)
    "#{user.displayed_name} <#{user.loginname}@fachschaft.cs.uni-kl.de>"
  end
end