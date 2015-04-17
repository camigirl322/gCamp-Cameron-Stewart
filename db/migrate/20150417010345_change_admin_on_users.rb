class ChangeAdminOnUsers < ActiveRecord::Migration
  def change
    remove_column :users, :admin
    add_column :users, :admin, :integer, default: 0
  end
end
