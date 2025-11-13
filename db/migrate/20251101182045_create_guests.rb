class CreateGuests < ActiveRecord::Migration[7.1]
  def change
    create_table :guests do |t|
      t.references :table, null: false, foreign_key: true
      t.string :name
      t.text :notes

      t.timestamps
    end
  end
end
