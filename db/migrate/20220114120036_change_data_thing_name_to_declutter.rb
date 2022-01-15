class ChangeDataThingNameToDeclutter < ActiveRecord::Migration[5.2]
  def change
    change_column :declutters, :thing_name, :string
  end
end
