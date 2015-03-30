class MoviesController < ApplicationController
	def new
		@movie = Movie.new
	end

	def create
		title = params[:title]

		@movie = Movie.new(movie_params)

	    @movie.rating = 5#NetflixRoulette.get_media_rating(@movie.title)
	    @movie.release_year = 2015#NetflixRoulette.get_media_release_year(@movie.title)
	    @movie.genre = "Best"#NetflixRoulette.get_media_category(@movie.title)
	    @movie.netflix_id = 69#NetflixRoulette.get_netflix_id(@movie.title)
	   
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
		@summary = "A Movie so good it broke the Netflix Ruolette site."#NetflixRoulette.get_media_summary(@movie.title)
		gon.title = @movie.title
	end

	def randoMovie
		@movie = Movie.find(Movie.order("random()").first(5))
		render 'show'
	end
	
	private

	    def movie_params
	      params.require(:movie).permit(:title, :genre)
	    end

end
