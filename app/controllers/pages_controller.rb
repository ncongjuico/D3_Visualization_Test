class PagesController < ApplicationController
	def index
		@characters = Character.all
		@genders = ["Very Masculine", "Masculine", "Neutral", "Feminine", "Very Feminine", "Prefer not to state"]
		@races = ["Asian", "Black", "Latinx", "Middle-Eastern", "Mixed", "White", "Prefer not to state"]

		if params[:character] == ""
			params[:character] = "gender"
		end
		if params[:gender_ids] == nil
			params[:gender_ids] = @genders
		end
		if params[:race_ids] == nil
			params[:race_ids] = @races
		end

	end
end

#Survey.joins("LEFT OUTER JOIN users ON surveys.user_id = users.id").where(users: {gender: params[:gender_ids], race: params[:race_ids]}).where(:character  => params[:Characters]).group(params[:character]).count