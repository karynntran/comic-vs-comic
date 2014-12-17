class RemoveMovesFromStories < ActiveRecord::Migration
  def change
    remove_column :stories, :moves, :integer
  end
end
