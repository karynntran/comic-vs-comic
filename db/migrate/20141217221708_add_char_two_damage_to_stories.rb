class AddCharTwoDamageToStories < ActiveRecord::Migration
  def change
    add_column :stories, :char_two_damage, :integer
  end
end
