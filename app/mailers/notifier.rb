class Notifier < ActionMailer::Base
  
  def start_event_mail(event)
    @event = event
    @url  = event_url(event)
    mail(to: ENV['ADMIN_EMAIL'], subject: 'Event start: ' + @event.name)
  end
  
end
