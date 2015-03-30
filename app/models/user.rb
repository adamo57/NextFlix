class User < ActiveRecord::Base
      has_many :friendships, class_name:  "Friendship",
                                  foreign_key: "friend_id",
                                  dependent:   :destroy
      has_many :user_movies, class_name:  "UserMovie",
                                  foreign_key: "user_id",
                                  dependent:   :destroy


      has_many :friends, through: :friendships, source: :friendOf
      has_many :movies, through: :user_movies, source: :movie


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

  #marks a movie as having been recently viewed
  def mark_viewed(movie)
    m = user_movies.find_by(movie_id: movie.id)
    #if movie has not been created we create it on the next line.
    if m == nil
      m = user_movies.create(movie_id: movie.id)
    end
    m.recently_viewed = 1
    m.save
  end

   # Likes a movie.
  def like(movie)
    m = user_movies.find_by(movie_id: movie.id)
    #if movie has not been created we create it on the next line.
    if m == nil
      m = user_movies.create(movie_id: movie.id)
    end
    m.liked = 1
    m.recently_viewed = 1
    m.save
  end

  # Unlike a movie.
  def unlike(movie)
    user_movies.find_by(movie_id: movie.id).destroy
  end

  # Returns true if the current user likes the movie
  def likes?(movie)
    movies.include?(movie) and user_movies.find_by(movie_id: movie.id).liked
  end
end
