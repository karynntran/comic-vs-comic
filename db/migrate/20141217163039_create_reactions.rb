class CreateReactions < ActiveRecord::Migration
  def change
    create_table :reactions do |t|
      t.text :reaction
      t.string :hit_or_miss
    end
  end
end
