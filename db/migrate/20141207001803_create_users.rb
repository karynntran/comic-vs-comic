class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.string :first_name
      t.string :last_name
      t.string :image
      t.text :powers
      t.text :friends
      t.boolean :win_or_lose
      t.timestamps
    end
  end
end

