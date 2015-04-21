class UsersController < ApplicationController
	def show
		@user = User.find(params[:id])
	end
	def new
		@user = User.new
	end
	def create
		@user = User.new(user_params)
		if @user.save
	        
			flash[:success] = "Welcome to the NextFlix!"
			redirect_to @user

		else
		  render 'new'
		end
	end

	def friends
		@user = User.find(params[:id])
		@friends = @user.friends.paginate(page: params[:page])

		sql = "requested_id = ?"
		@requests = FriendRequest.where(sql, @user.id).paginate(page: params[:page])
	end

	private

	def user_params
	  params.require(:user).permit(:name, :email, :password,
	                               :password_confirmation)
	end
end
