class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.integer :moves
      t.boolean :completed
      t.timestamps
    end
  end
end
