class CreateServerGroups < ActiveRecord::Migration
  def change
    create_table :server_groups do |t|
      t.string :name
      t.belongs_to :project, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
