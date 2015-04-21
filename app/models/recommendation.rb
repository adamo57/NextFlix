class Recommendation < ActiveRecord::Base
	belongs_to :recee, class_name: "User"
	belongs_to :recer, class_name: "User"
end
