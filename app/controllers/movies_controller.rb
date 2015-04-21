class MoviesController < ApplicationController
	#around_filter :catch_not_found

	def new
		@movie = Movie.new
	end

	def create
		title = params[:title]

		@movie = Movie.find_by(title: title)

		if @movie == nil
			@movie = Movie.new(movie_params)
			@@error_message = ""
			begin
			    @movie.rating = NetflixRoulette.get_media_rating(@movie.title)
			    @movie.release_year = NetflixRoulette.get_media_release_year(@movie.title)
			    @movie.genre = NetflixRoulette.get_media_category(@movie.title)
			    @movie.netflix_id = NetflixRoulette.get_netflix_id(@movie.title)
			    @@error_message = ""
			rescue
				@@error_message = "Could not connect to the NetflixRoulette API"
			end
	   
		    if @movie.save
		    	if current_user
		    		current_user.mark_viewed(@movie)
		    	end
		    	redirect_to @movie
		    else
		    	render 'new'
		    end
		else#movie already exists in database
			if current_user
		    	current_user.mark_viewed(@movie)
			redirect_to @movie
		end
	end

	def show
		@movie = Movie.find(params[:id])
		@summary = NetflixRoulette.get_media_summary(@movie.title)
		gon.title = @movie.title
	end

	def randomMovie
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
	end
	
	private

	    def movie_params
<<<<<<< HEAD
	      params.require(:movie).permit(:title)
=======
	      params.require(:movie).permit(:title, :genre, :image_url)
>>>>>>> movies
	    end

	    #def catch_not_found
		#  yield
		#rescue ActiveRecord::RecordNotFound
		#	flash[:danger] = "Record Not Found"
		#	redirect_to root_url
		#end
end
