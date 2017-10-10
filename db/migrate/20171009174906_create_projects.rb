class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title
      t.string :short_description
      t.text :description
      t.belongs_to :user, index: true
      t.timestamps null: false
    end
  end
end
