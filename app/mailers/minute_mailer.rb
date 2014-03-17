class MinuteMailer < ActionMailer::Base
  default from: 'no-reply@lallafa.fachschaft.cs.uni-kl.de'
  default to: 'fsinfo@fachschaft.cs.uni-kl.de'
  default sender: 'no-reply@lallafa.fachschaft.cs.uni-kl.de'
    
  def send_draft minute, user
    @minutes_minute = minute
    mail(from: get_email_with_name(user), subject: "Protokoll der FSR-Sitzung vom #{l @minutes_minute.date} [ENTWURF]")
  end
  def publish minute, user
    @minutes_minute = minute
    mail(from: get_email_with_name(user), subject: "Protokoll der FSR-Sitzung vom #{l @minutes_minute.date}")
  end

  private
  
  def get_email_with_name(user)
    "#{user.displayed_name} <#{user.loginname}@fachschaft.cs.uni-kl.de>"
  end
end
