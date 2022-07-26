# Preview all emails at http://localhost:3000/rails/mailers/event_mailer
class EventMailerPreview < ActionMailer::Preview
  def send_event_to_user
    event_history = UserEventHistory.first

    EventMailer.with(user_event_history_id: event_history.id).send_event_to_user
  end
end
