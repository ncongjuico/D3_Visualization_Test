class ChangeCharacterDescriptionToText < ActiveRecord::Migration[5.1]
    def change
  	change_column :characters, :character_desc, :text
  end
end
