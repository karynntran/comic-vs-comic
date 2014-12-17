class RemoveCharOneMovesFromStories < ActiveRecord::Migration
  def change
    remove_column :stories, :char_one_moves, :integer
  end
end
