class AddSendTimeAndMessageParamToEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :send_time, :string, default: '00:00'
    add_column :events, :message_params, :json
  end
end
