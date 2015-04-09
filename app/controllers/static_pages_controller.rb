class StaticPagesController < ApplicationController
  def home
  	@popular = getPopularMovies  	
  end

  def about
  end

  private
  	def getPopularMovies
		base_url = "http://api-public.guidebox.com/v1.43/US/rKaihTUA2eO9IoFec4f2jvFrKwdJxxhq"
		pop_url =  "/movies/all/0/5/all/all"

		url = base_url + pop_url

		response = HTTParty.get(url)
		hash = JSON.parse(response.body)

		#add code for making movies and with images and return them.
		hash = hash['results']
		popular = []
		hash.each do |m|
			title = m['title']
			image_url = m['poster_240x342']
			image_url = image_url.gsub("\\", "")

			movie = Movie.new(title: title)
			movie.image_url = image_url

			popular << movie			
		end
		return popular
	end
end
