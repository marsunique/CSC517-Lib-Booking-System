class AddIndexToRoomsNumber < ActiveRecord::Migration[5.0]
  def change
    add_index :rooms, :number
  end
end
