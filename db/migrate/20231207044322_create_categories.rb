class CreateCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :categories do |t|
      t.string :name, index: { unique: true }
      t.integer :state, default: 1
      t.belongs_to :vertical, foreign_key: true

      t.timestamps
    end
  end
end
