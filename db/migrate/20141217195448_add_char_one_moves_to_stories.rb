class AddCharOneMovesToStories < ActiveRecord::Migration
  def change
    add_column :stories, :char_one_moves, :integer
  end
end
