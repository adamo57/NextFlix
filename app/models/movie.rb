class Movie < ActiveRecord::Base
	attr_accessor :image_url
	validates :title, presence: true
	#validates :rating, presence: true
	#validates :genre, presence: true
	#validates :release_year, presence: true

	def isOnNetflix?()
		not genre == "Unable to locate data"
	end


end
