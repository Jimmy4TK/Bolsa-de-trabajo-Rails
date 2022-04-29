class CreateWorkNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :work_notifications do |t|
      t.string :name 
      t.belongs_to :company

      t.timestamps
    end
  end
end
