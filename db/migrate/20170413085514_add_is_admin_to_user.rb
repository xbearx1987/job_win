class AddIsAdminToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :name, :string
    add_column :users, :is_admin, :boolean, default: false
    add_column :users, :is_website_admin, :boolean, default: false
  end
end
