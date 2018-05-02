class CharactersController < ApplicationController
	def search

	end

	def index
    	@characters = Character.all
  	end
end
