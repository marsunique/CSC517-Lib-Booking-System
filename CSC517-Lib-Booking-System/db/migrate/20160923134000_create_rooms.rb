class CreateRooms < ActiveRecord::Migration[5.0]
  def change
    drop_table :rooms
    create_table :rooms do |t|
      t.string :number
      t.string :size
      t.string :building

      t.timestamps
    end
  end
end
