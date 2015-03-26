class Friendship < ActiveRecord::Base
  belongs_to :friend, class_name: "User"
  belongs_to :friendOf, class_name: "User"
  validates :friend_id, presence: true
  validates :friendOf_id, presence: true
end
