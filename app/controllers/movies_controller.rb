class MoviesController < ApplicationController
	def new
		@movie = Movie.new
	end

	def create
		title = params[:title]

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
	end

	def show
		@movie = Movie.find(params[:id])
		@summary = NetflixRoulette.get_media_summary(@movie.title)
		gon.title = @movie.title
		@error_message = @@error_message
	end

	def randoMovie
		@movie = Movie.find(Movie.order("random()").first(5))
		render 'show'
	end
	
	private

	    def movie_params
	      params.require(:movie).permit(:title, :genre, :image_url)
	    end
end
