class CreateVerticals < ActiveRecord::Migration[7.1]
  def change
    create_table :verticals do |t|
      t.string :name, index: { unique: true }

      t.timestamps
    end
  end
end
