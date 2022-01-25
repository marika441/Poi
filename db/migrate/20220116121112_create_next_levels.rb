class CreateNextLevels < ActiveRecord::Migration[5.2]
  def change
    create_table :next_levels do |t|
      t.integer :level
      t.integer :thresold
      
      t.timestamps
    end
  end
end
