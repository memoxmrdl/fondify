class AddAdminReferenceToProject < ActiveRecord::Migration
  def change
    add_reference :projects, :admin, index: true
  end
end
