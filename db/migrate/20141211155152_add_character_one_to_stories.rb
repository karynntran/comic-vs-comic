class AddCharacterOneToStories < ActiveRecord::Migration
  def change
    add_column :stories, :character_one, :string
  end
end
