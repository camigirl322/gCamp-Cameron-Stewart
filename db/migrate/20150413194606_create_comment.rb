class CreateComment < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :description
      t.datetime :created_at
      t.integer :user_id
      t.integer :task_id
    end
  end
end
