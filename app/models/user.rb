# frozen_string_literal: true

class User < ApplicationRecord
validates :first_name, :birthday, :time_zone, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }

  after_commit :user_event_schedule, on: :create

  has_many :user_event_histories, dependent: :destroy

  private

  def user_event_schedule
    UserEventSchedulerWorker.perform_async(id, 'new_user')
  end
end
