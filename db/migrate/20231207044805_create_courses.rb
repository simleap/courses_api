class CreateCourses < ActiveRecord::Migration[7.1]
  def change
    create_table :courses do |t|
      t.string :name
      t.string :author
      t.integer :state, default: 1
      t.belongs_to :category, foreign_key: true

      t.timestamps
    end
  end
end
