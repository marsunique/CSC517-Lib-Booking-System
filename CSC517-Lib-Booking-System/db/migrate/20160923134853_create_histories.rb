class CreateHistories < ActiveRecord::Migration[5.0]
  def change
    create_table :histories do |t|
      t.string :number
      t.string :email
      t.string :date
      t.string :begintime
      t.string :endtime

      t.timestamps
    end
  end
end
