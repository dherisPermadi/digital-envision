# frozen_string_literal: true

class Event < ApplicationRecord
  validates :title, :message, presence: true

  after_commit :user_event_schedule, on: :create
  
  has_many :user_event_histories, dependent: :destroy

  private

  def user_event_schedule
    UserEventSchedulerWorker.perform_async(id, 'new_event')
  end
end
