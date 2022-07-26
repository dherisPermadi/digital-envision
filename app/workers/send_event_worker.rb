class SendEventWorker
  include Sidekiq::Worker

  def perform()
    events = Event.all
 
    events.each do |event|

      active_timezones = zones_with_local_time(event.send_time)

      send_event_to_users(event.id, active_timezones) if active_timezones.present?
    end
  end

  def zones_with_local_time(send_time)
    local_time = Time.zone.parse("#{Time.zone.now.strftime('%Y/%m/%d %H')}:00:00")
    ActiveSupport::TimeZone.all.select { |tz| tz.parse("#{send_time}:00") == local_time }.map(&:name)
  end

  def send_event_to_users(event_id, zones)
    current_day     = Date.today.strftime("%m/%d")
    event_histories = UserEventHistory.joins(:user)
                                      .scheduled
                                      .on_event(event_id)
                                      .where("DATE_FORMAT(users.birthday, '%m/%d') = :current_day AND users.time_zone in (:zones)", {current_day: current_day, zones: zones})

    if event_histories.present?
      event_histories.update_all(status: 'ready_to_send')
      event_histories.each do |event_history|
        EventMailer.send_event_to_user(event_history.id).deliver!
        event_history.update(status:'mail_sent')
      end
    end
  end
end
