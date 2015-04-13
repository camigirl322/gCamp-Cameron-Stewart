class ChangeCreatedAtOnComments < ActiveRecord::Migration
  def change
    change_column :comments, :created_at, :datetime, null: false
  end
end
