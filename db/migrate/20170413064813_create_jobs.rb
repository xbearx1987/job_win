class CreateJobs < ActiveRecord::Migration[5.0]
  def change
    create_table :jobs do |t|
      t.string :name
      t.text :content
      t.string :company
      t.string :category
      t.string :location
      t.integer :wage_lower_bound
      t.integer :wage_upper_bound
      t.string :contact_mail

      t.timestamps
    end
  end
end
