class FriendRequestsController < ApplicationController
  def create
    user = User.find(params[:requested_id])
    current_user.addSentRequest(user)
    user.addPendingRequest(current_user)
    redirect_to user
  end

  def destroy
    user = FriendRequests.find(params[:id]).requester
    current_user.removeSentRequest(user)
    user.removePendingRequest(current_user)
    redirect_to user
  end
end
