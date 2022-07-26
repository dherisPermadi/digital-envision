class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string   :first_name, null: false
      t.string   :last_name, null: false
      t.string   :email, null: false, index: true
      t.date     :birthday, null: false
      t.string   :time_zone, null: false
      t.timestamps
    end
  end
end
