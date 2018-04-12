class CreateRead < ActiveRecord::Migration[5.1]
  def change
    create_table :reads do |t|
    	t.integer :user_id
    	t.integer :character_id
    	t.string :aprnt_race
    	t.string :aprnt_gender
    	t.string :aprnt_species
    	t.timestamps
    end
  end
end
