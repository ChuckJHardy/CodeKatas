class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :avatar, null: false

      t.decimal :latitude, precision: 7, scale: 4, null: false
      t.decimal :longitude, precision: 7, scale: 4, null: false

      t.timestamps
    end
  end
end
