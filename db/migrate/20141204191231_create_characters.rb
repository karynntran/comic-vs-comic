class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |t|
      t.string :name
      t.string :powers
      t.string :image
      t.string :team
      t.string :friends
      t.string :enemies
      t.string :bio
      t.timestamps
    end
  end
end
