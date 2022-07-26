module Api
  module V1
    class EventsController < ApplicationController
      before_action :set_event, only: %i[show update destroy]

      def create
        event = Event.new(event_params)
        if event.save
          response_success('Add New Event Succeed', event, 201)
        else
          response_error('Add New Event Failed', event.errors.full_messages)
        end
      end

      def update
        if @event.update(event_params)
          response_success('Update Event Succeed', @event)
        else
          response_error('Update Event Failed', @event.errors.full_messages)
        end
      end

      def destroy
        return unless @event.destroy

        response_success('Delete Event Succeed')
      end

      private

      def set_event
        @event = Event.find(params[:id])
      rescue StandardError
        response_error('Event Error', 'Data not found')
      end

      def event_params
        params.require(:event).permit(:title, :message, :send_time, message_params: [])
      end
    end
  end
end
