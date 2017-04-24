class AddIsHiddenToLocation < ActiveRecord::Migration[5.0]
  def change
    add_column :locations, :is_hidden, :boolean, default: false
  end
end
