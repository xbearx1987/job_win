class CreateLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :locations do |t|
      t.string :name
      t.integer :sort
      t.boolean :is_hidden, default: false

      t.timestamps
    end
  end
end
