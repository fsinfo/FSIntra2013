class MinuteMailer < ActionMailer::Base
  default from: 'intranet@fachschaft.cs.uni-kl.de'
  default to: 'fsinfo@fachschaft.cs.uni-kl.de'
  
  def send_draft minute, user
    @minutes_minute = minute
    mail(subject: "Protokoll der FSR-Sitzung vom #{l @minutes_minute.date} [ENTWURF]")
  end

  private
  
  def get_email_with_name(user)
    "#{user.displayed_name} <#{user.email}>"
  end
end
