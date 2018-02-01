class Sheet < ApplicationRecord
	include Filterable
	belongs_to	:user
	validates	:level, numericality: { greater_than: 0, less_than: 21 }, :if => Proc.new { |m| m.level != nil }
	serialize :abilityscores, Hash
	serialize :saves, Hash
	serialize :skillmods, Hash
	serialize :classfeatures, Hash
	serialize :attacks, Hash
	scope :level, -> (level) { where level: level }
	scope :classes, -> (classes) { where classes: classes }
	scope :race, -> (race) { where race: race }
	scope :min_level, -> (min_level) { where "level >= ?", min_level }
	scope :max_level, -> (max_level) { where "level <= ?", max_level }


	def autocalc_all #Call every calc method in here
		calc_ability_mods
		calc_profbonus
	end

	def calc_ability_mods
		['str','dex','con','int','wis','cha'].each do |s|
			score = self.abilityscores[s]
			if score == "0" or score.to_i != 0
				abilityscores[s+'-mod'] = (score.to_i/2) - 5
			end
		end
	end

	def calc_profbonus
		if level.to_i > 0
			self.profbonus = 2 + (level-1)/4
		end
	end


end
