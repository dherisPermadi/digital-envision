# frozen_string_literal: true

class UserEventHistory < ApplicationRecord
  belongs_to :user
  belongs_to :event

  enum status: [:in_schedule, :ready_to_send, :mail_sent]

  scope :scheduled, -> { where(status: 'in_schedule') }
  scope :unsent, -> { where(status: 'ready_to_send') }
  scope :delivered, -> { where(status: 'mail_sent') }
  scope :on_event, -> (event_id) { where(event_id: event_id) }

  
  def full_name
    user.last_name.present? ? "#{user.first_name} #{user.last_name}" : user.first_name
  end

  def format_message
    message = event.message

    if event.message_params.present?
      event.message_params.each_with_index do |param, index|
        message.gsub!("{#{index}}", self.try(param))
      end
    end

    message
  end
end
