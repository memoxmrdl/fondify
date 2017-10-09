class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.belongs_to :admin, index: true
      t.belongs_to :project, index: true
      t.text :message
      t.boolean :updated, default: false
      t.timestamps null: false
    end
  end
end
