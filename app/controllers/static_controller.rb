class StaticController < ApplicationController
	def lookup
	end

	def lookup_post
		#Spells
		results = RestClient.get 'http://dnd5eapi.co/api/spells/?name=' + params['spell-query'].titleize
		results = JSON.parse(results)

		if results['count'] == 0
			@results = 0
		else
			results = RestClient.get results['results'][0]['url']
			@results = JSON.parse(results)
		end

		respond_to do |f|
			p "aaaaaaaaaaaaa"
			p f
			f.js
		end

	end
end
