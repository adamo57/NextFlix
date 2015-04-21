class FriendRequestsController < ApplicationController
	before_action :logged_in_user

  def create
    user = User.find(params[:requested_id])
    current_user.addSentRequest(user)
    redirect_to user
  end

  def destroy
    user = FriendRequest.find(params[:id]).requested
    current_user.removeRequest(user)
    redirect_to user
  end
end
