class UserMoviesController < ApplicationController
  before_action :logged_in_user

  def create
    movie = Movie.find(params[:movie_id])
    current_user.like(movie)
    redirect_to movie
  end

  def destroy
    #movie = UserMovie.find(params[:id]).movie
    #current_user.unlike(movie)
    #redirect_to movie
  end
end
