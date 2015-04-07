class Movie < ActiveRecord::Base
	validates :title, presence: true
	validates :rating, presence: true
	validates :genre, presence: true
	validates :release_year, presence: true
	validates :netflix_id, presence: true
end
