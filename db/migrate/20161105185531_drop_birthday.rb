class DropBirthday < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :birthday
  end
end
