class CreateDeclutters < ActiveRecord::Migration[5.2]
  def change
    create_table :declutters do |t|
      t.text :thing_name
      t.string :thing_image_id
      t.text :caption
      t.integer :user_id
      t.integer :point
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
