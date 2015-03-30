class UsersController < ApplicationController
	def show
		@user = User.find(params[:id])
		#sql to get liked movies by user
		sql = "id IN (SELECT movie_id FROM user_movies where user_id = #{@user.id} AND liked = ?)"
		@liked_movies = Movie.where(sql, true).paginate(page: params[:page])
		#sql to get recently viewed movies by user
		sql = "id IN (SELECT movie_id FROM user_movies where user_id = #{@user.id} AND recently_viewed = ?)"
		@viewed_movies = Movie.where(sql, true).paginate(page: params[:page])
	end
	def new
		@user = User.new
	end
	def create
		@user = User.new(user_params)
		if @user.save
		  # Handle a successful save
	        log_in @user
			flash[:success] = "Welcome to the NextFlix!"
			redirect_to @user

		else
		  render 'new'
		end
	end

	def friends
		@user = User.find(params[:id])
		@friends = @user.friends.paginate(page: params[:page])
	end

	private

		def user_params
		  params.require(:user).permit(:name, :email, :password,
		                               :password_confirmation)
		end

		# Confirms a logged-in user.
	    def logged_in_user
	      unless logged_in?
	      	store_location
	        flash[:danger] = "Please log in."
	        redirect_to login_url
	      end
	    end

	    # Confirms the correct user.
	    def correct_user
	      @user = User.find(params[:id])
	      redirect_to(root_url) unless current_user?(@user)
	    end

	    # Confirms an admin user.
	    def admin_user
	      redirect_to(root_url) unless current_user.admin?
	    end
end
