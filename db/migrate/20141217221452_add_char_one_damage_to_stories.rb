class AddCharOneDamageToStories < ActiveRecord::Migration
  def change
    add_column :stories, :char_one_damage, :integer
  end
end
