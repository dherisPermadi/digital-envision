class CreateUserEventHistories < ActiveRecord::Migration[6.0]
  def change
    create_table :user_event_histories do |t|
      t.references :user
      t.references :event
      t.integer   :status, null: false, default: 0
      t.timestamps
    end

    add_index :user_event_histories, [:user_id, :event_id], unique: true
  end
end
