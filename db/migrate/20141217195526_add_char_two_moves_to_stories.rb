class AddCharTwoMovesToStories < ActiveRecord::Migration
  def change
    add_column :stories, :char_two_moves, :integer
  end
end
