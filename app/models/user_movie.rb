class UserMovie < ActiveRecord::Base
	belongs_to :user, class_name: "User"
	belongs_to :movie, class_name: "Movie"
	validates :user_id, presence: true
	validates :movie_id, presence: true

	def check_times
		movies = UserMovie.all
		movies.each do |m|
			#difference should changed to somthing other than 1 hour in production
			if m.updated_at - Time.now() > 1.hour
				#0 means false for the database
				m.recently_viewed = 0
				m.save
			end
		end
	end
end
