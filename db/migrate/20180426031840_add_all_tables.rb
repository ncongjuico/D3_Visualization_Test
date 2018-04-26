class AddAllTables < ActiveRecord::Migration[5.1]
  def change
  	create_table :users do |t|
      t.string :email
      t.string :gender
      t.string :race
      t.string :picture
      t.integer :user_type

      t.timestamps
    end
    create_table :surveys do |t|
      t.integer :user_id
      t.integer :character_id
      t.string :race
      t.string :gender
      t.string :species

      t.timestamps
    end
    create_table :characters do |t|
    	t.string :character_name
    	t.string :game_name
    	t.string :character_desc
    	t.string :picture_link
    	t.string :character_bio_link
      t.timestamps
    end
  end
end
