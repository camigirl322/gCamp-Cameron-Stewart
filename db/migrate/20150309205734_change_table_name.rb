class ChangeTableName < ActiveRecord::Migration
  def change
    remove_column :memberships, :role
    add_column :memberships, :role, :integer, :default => 0
  end
end
