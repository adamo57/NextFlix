class FriendshipsController < ApplicationController
  before_action :logged_in_user

  def create
    user = User.find(params[:friend_id])
    current_user.friend(user)
    user.friend(current_user)

    #FriendRequest.find_by(requester_id: user.id, requested_id: current_user.id).destroy

    redirect_to user
  end

  def destroy
  	user = Friendship.find(params[:id]).friendOf
    current_user.unfriend(user)
    user.unfriend(current_user)
    redirect_to user
  end
end
