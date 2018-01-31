class Sheet < ApplicationRecord
	include Filterable
	belongs_to	:user
	validates	:level, numericality: { greater_than: 0, less_than: 20 }
	scope :level, -> (level) { where level: level }
	scope :classes, -> (classes) { where classes: classes }
	scope :race, -> (race) { where race: race }
	scope :min_level, -> (min_level) { where "level >= ?", min_level }
	scope :max_level, -> (max_level) { where "level <= ?", max_level }
end
