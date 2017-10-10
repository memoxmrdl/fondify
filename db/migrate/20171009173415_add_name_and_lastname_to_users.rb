class AddNameAndLastnameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string, null: false
    add_column :users, :last_name, :string, null: false
  end
end
