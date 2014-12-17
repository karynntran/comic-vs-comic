class RemoveCharTwoMovesFromStories < ActiveRecord::Migration
  def change
    remove_column :stories, :char_two_moves, :integer
  end
end
