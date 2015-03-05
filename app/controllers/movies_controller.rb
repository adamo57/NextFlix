class MoviesController < ApplicationController
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

	private

	    def movie_params
	      params.require(:movie).permit(:title)
	    end

end
