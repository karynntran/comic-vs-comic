class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |t|
      t.string :name
      t.text :powers
      t.text :image
      t.text :team
      t.text :friends
      t.text :enemies
      t.text :bio
      t.timestamps
    end
  end
end
