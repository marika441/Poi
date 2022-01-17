class RenameExpColumToUsers < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :exp, :exp_point
  end
end
