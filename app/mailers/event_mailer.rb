class EventMailer < ApplicationMailer
  def send_event_to_user(user_event_history_id)
    @event_history = UserEventHistory.find(user_event_history_id)

    mail(to: @event_history.user.email, subject: "Event - #{@event_history.event.title}")
  end
end
