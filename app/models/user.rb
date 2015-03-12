class User < ActiveRecord::Base
    has_many :active_relationships, class_name:  "Friend",
                                  foreign_key: "friend2_id",
                                  dependent:   :destroy
    has_many :passive_relationships, class_name:  "Friend",
                                   foreign_key: "friend1_id",
                                   dependent:   :destroy

    has_many :friends, through: :active_relationships, source: :friend2
    has_many :friendsOf, through: :passive_relationships, source: :friend1




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
    active_relationships.create(friend2_id: other_user.id)
  end

  # Unfriends a user.
  def unfriend(other_user)
    active_relationships.find_by(friend2_id: other_user.id).destroy
  end

  # Returns true if the current user is a friend of the other user.
  def friends?(other_user)
    friends.include?(other_user)
  end
end
