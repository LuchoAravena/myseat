class CreateTables < ActiveRecord::Migration[7.1]
  def change
    create_table :tables do |t|
      t.integer :number
      t.integer :capacity
      t.text :notes

      t.timestamps
    end
  end
end
