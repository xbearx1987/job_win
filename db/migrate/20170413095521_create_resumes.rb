class CreateResumes < ActiveRecord::Migration[5.0]
  def change
    create_table :resumes do |t|
      t.string :job_id
      t.string :user_id
      t.text :content
      t.string :attachment

      t.timestamps
    end
  end
end
