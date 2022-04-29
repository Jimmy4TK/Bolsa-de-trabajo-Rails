class CreateStatusWorkNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :status_work_notifications do |t|
      t.integer :status, default: 0
      t.belongs_to :candidate
      t.belongs_to :work_notification

      t.timestamps
    end
  end
end
