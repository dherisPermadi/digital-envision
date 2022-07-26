# frozen_string_literal: true
require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  namespace :api, defaults: { format: :json }, path: 'api' do
    namespace :v1 do
      resources :events
      resources :user_event_histories
      resources :users
    end
  end

  mount Sidekiq::Web, at: "/sidekiq"
end
