class Character < ApplicationRecord
	has_many :surveys

	def self.search(param)
		param.strip!
		param.downcase!
		to_send_back = (character_name_matches(param) + game_name_matches(param)).uniq
		return nil unless to_send_back
		to_send_back
	end

	def self.character_name_matches(param)
		matches('character_name', param)

	end

	def self.game_name_matches(param)
		matches('game_name', param)
	end

	def self.matches(field_name, param)
		Character.where("#{field_name} like ?", "%#{param}%")
	end

end