class User < ActiveRecord::Base
      has_many :friendships, class_name:  "Friendship",
                                  foreign_key: "friend_id",
                                  dependent:   :destroy
      has_many :active_friend_requests, class_name:  "FriendRequest",
                                  as: :requested,
                                  foreign_key: "requester_id",
                                  dependent:   :destroy
      has_many :passive_friend_requests, class_name:  "FriendRequest",
                                  foreign_key: "requested_id",
                                  dependent:   :destroy


      has_many :friends, through: :friendships, source: :friendOf
      has_many :sent_requests, through: :active_friend_requests, source: :requester
      has_many :pending_requests, through: :passive_friend_requests, source: :requested


	attr_accessor :remember_token
  before_save{ self.email = email.downcase }
	validates :name,  presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensiive: false }
    has_secure_password   
    validates :password, length: { minimum: 6 }  

  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end  

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

   # Returns true if the given token matches the digest.
  def authenticated?(remember_token)
  	return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

  # Friends a user.
  def friend(other_user)
    friendships.create(friendOf_id: other_user.id)
  end

  # Unfriends a user.
  def unfriend(other_user)
    friendships.find_by(friendOf_id: other_user.id).destroy
  end

  # Returns true if the current user is a friend of the other user.
  def friends?(other_user)
    friends.include?(other_user)
  end

  #add a new sent friend
  def addSentRequest(requested_user)
    sent_requests.create(requested_id: requested_user.id)
  end

  #deletes a friend request
  def removeRequest(requested_user)
    sent_requests.find_by(requested_id: requested_user.id).destroy
  end

  #check if user has sent a friend request
  def sent_request?(other_user)
    sent_requests.include?(other_user)
  end

  #add a new pending friend request
  def addPendingRequest(requesting_user)
    pending_requests.create(requester_id: requesting_user.id)
  end

  #remove/reject a pending friend request
  def removePendingRequest(requesting_user)
    pending_requests.find_by(requester_id: requester_user.id).destroy
  end  
end