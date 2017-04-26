class UpdateColumnToJob < ActiveRecord::Migration[5.0]
  def change
    change_column :jobs, :location, :integer
    change_column :jobs, :category, :integer
  end
end
