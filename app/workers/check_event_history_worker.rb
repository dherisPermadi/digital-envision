class CheckEventHistoryWorker
  include Sidekiq::Worker

  def perform()
    send_unsent_events
    reset_sent_events
  end

  def send_unsent_events
    event_histories = UserEventHistory.unsent
  
    if event_histories.present?
      event_histories.each do |event_history|
        EventMailer.send_event_to_user(event_history.id).deliver!
        event_history.update(status:'mail_sent')
      end
    end
  end

  def reset_sent_events
    event_histories = UserEventHistory.delivered

    event_histories.update_all(status: 'in_schedule')
  end
end
