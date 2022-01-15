class RenameThingNameColumnToDeclutters < ActiveRecord::Migration[5.2]
  def change
    rename_column :declutters, :thing_name, :title
  end
end
