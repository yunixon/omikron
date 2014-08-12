def start_event_mail
  event = FactoryGirl.build(:event)
  Notifier.start_event_mail(event)
end