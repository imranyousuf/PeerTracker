class Feedback < ActiveRecord::Base
	belongs_to :giver_user, :class_name => "User"
	belongs_to :receiver_user, :class_name => "User"
end
