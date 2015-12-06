class RenameAccountAvatarFieldsColumn < ActiveRecord::Migration
  def change
	rename_column :profiles, :profile_pic, :avatar
	add_column :profiles, :avatar_tiny, :string
  end
end
