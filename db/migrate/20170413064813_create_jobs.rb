class CreateJobs < ActiveRecord::Migration[5.0]
  def change
    create_table :jobs do |t|
      t.integer :user_id
      t.string :name
      t.text :content
      t.string :company
      t.integer :category_id
      t.integer :location_id
      t.integer :wage_lower_bound
      t.integer :wage_upper_bound
      t.string :contact_mail
      t.boolean :is_hidden, default: false


      t.timestamps
    end
  end
end
