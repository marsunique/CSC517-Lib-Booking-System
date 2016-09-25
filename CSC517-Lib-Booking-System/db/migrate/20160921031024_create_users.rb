class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    drop_table :users
    create_table :users do |t|
      t.string :email
      t.string :password
      t.string :name
      t.string :authority

      t.timestamps
    end
  end
end
