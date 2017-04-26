class ChangeColumnToJob < ActiveRecord::Migration[5.0]
  def change
    rename_column :jobs, :location, :location_id
    rename_column :jobs, :category, :category_id
  end
end
