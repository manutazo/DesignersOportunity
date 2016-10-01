class CreateDesigns < ActiveRecord::Migration[5.0]
  def change
    create_table :designs do |t|
    t.belongs_to :user, index: true
    t.string :title, null: false
    t.text :description, null: false
    t.timestamps null: false
    t.string :gender, null: false
    t.string :season, null: false

      t.timestamps
    end
  end
end
