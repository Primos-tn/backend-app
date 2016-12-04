class AddSeenToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :seen, :integer, default: 0
  end
end
