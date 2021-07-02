class CreateMeetings < ActiveRecord::Migration[6.1]
  def change
    create_table :meetings do |t|
      t.date :start_date
      t.time :start_time
      t.string :description
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
