class MoviesController < ApplicationController
	#around_filter :catch_not_found

	def new
		@movie = Movie.new
	end

	def create
		title = params[:title]

		@movie = Movie.new(movie_params)

	    @movie.rating = NetflixRoulette.get_media_rating(@movie.title)
	    @movie.release_year = NetflixRoulette.get_media_release_year(@movie.title)
	    @movie.genre = NetflixRoulette.get_media_category(@movie.title)
	    @movie.netflix_id = NetflixRoulette.get_netflix_id(@movie.title)
	   
	    if @movie.save
	    	redirect_to @movie
	    else
	    	render 'new'
	    end
	end

	def show
		@movie = Movie.find(params[:id])
		@summary = NetflixRoulette.get_media_summary(@movie.title)
		gon.title = @movie.title
	end

	def randomMovie
<<<<<<< HEAD
		id = Random.rand(9000)

	    base_url = "http://api-public.guidebox.com/v1.43/US/rKaihTUA2eO9IoFec4f2jvFrKwdJxxhq"
		source_url = "/movie/"

		url = base_url + source_url + id.to_s

		response = HTTParty.get(url)
		hash = JSON.parse(response.body)

		title = hash['title']		

		@movie = Movie.new(title: title)

	    @movie.rating = NetflixRoulette.get_media_rating(@movie.title)
	    @movie.release_year = NetflixRoulette.get_media_release_year(@movie.title)
	    @movie.genre = NetflixRoulette.get_media_category(@movie.title)
	    @movie.netflix_id = NetflixRoulette.get_netflix_id(@movie.title)
	   
	    if @movie.save
	    	redirect_to @movie
	    end
=======
>>>>>>> finishRando
	end
	
	private

	    def movie_params
	      params.require(:movie).permit(:title)
	    end

	    #def catch_not_found
		#  yield
		#rescue ActiveRecord::RecordNotFound
		#	flash[:danger] = "Record Not Found"
		#	redirect_to root_url
		#end
end
