class Movie < ActiveRecord::Base
	#validates :title, presence: true
	#alidates :rating, presence: true
	#validates :genre, presence: true
	#validates :release_year, presence: true

	def isOnNetflix?()
		not genre == "Unable to locate data"
	end
end
