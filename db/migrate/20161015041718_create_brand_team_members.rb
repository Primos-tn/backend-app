class CreateBrandTeamMembers < ActiveRecord::Migration
  def change
    create_table :brand_team_members do |t|
      t.integer :account_id
      t.integer :brand_id
      t.boolean :is_admin
      t.integer :added_by

      t.timestamps null: false
    end
  end
end
