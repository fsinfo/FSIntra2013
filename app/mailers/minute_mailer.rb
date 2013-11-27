class MinuteMailer < ActionMailer::Base
  default from: 'intranet@fachschaft.cs.uni-kl.de'
  default to: 'm_hoffmann09@fachschaft.cs.uni-kl.de'
  
  def send_draft minute
    @minutes_minute = minute
    mail(subject: "Protokoll der FSR-Sitzung vom #{l @minutes_minute.date} [ENTWURF]")
  end

end
