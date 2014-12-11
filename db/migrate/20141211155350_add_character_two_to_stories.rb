class AddCharacterTwoToStories < ActiveRecord::Migration
  def change
    add_column :stories, :character_two, :string
  end
end
