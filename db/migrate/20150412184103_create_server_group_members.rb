class CreateServerGroupMembers < ActiveRecord::Migration
  def change
    create_table :server_group_members do |t|
      t.belongs_to :server_group, index: true, foreign_key: true
      t.belongs_to :user, index: true, foreign_key: true
      t.string :role

      t.timestamps null: false
    end
  end
end
