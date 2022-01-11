class CreateDeclutterComments < ActiveRecord::Migration[5.2]
  def change
    create_table :declutter_comments do |t|
      t.text :comment
      t.integer :user_id
      t.integer :declutter_id

      t.timestamps
    end
  end
end
