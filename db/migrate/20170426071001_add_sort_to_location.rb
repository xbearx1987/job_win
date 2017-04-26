class AddSortToLocation < ActiveRecord::Migration[5.0]
  def change
    add_column :locations, :sort, :integer
  end
end
