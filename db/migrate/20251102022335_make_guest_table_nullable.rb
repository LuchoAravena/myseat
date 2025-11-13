class MakeGuestTableNullable < ActiveRecord::Migration[7.1]
  def change
    change_column_null :guests, :table_id, true
  end
end