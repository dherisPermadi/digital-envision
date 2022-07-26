class UserEventSchedulerWorker
  include Sidekiq::Worker

  def perform(id, type)
    @id = id

    if type == 'new_user'
      generate_user_to_event
    else
      generate_event_to_user
    end
  end

  def generate_user_to_event
    events = Event.all

    if events.present?
      events.each do |event|
        UserEventHistory.find_or_create_by(user_id: @id, event_id: event.id)
      end
    end
  end

  def generate_event_to_user
    users = User.all

    if users.present?
      users.each do |user|
        UserEventHistory.find_or_create_by(user_id: user.id, event_id: @id)
      end
    end
  end
end
