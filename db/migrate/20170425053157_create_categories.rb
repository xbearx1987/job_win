class CreateCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :categories do |t|
      t.string :name
      t.string :icon
      t.integer :sort
      t.boolean :is_hidden, default: false
      t.boolean :is_lock, default: false

      t.timestamps
    end
  end
end
