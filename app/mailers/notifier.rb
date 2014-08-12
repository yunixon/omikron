class Notifier < ActionMailer::Base
  
  def start_event_mail(event, admin)
    @event = event
    @url  = event_url(event)
    mail(to: admin.email, subject: 'Event start: ' + @event.name)
  end
  
end
