class Assignment < ActiveRecord::Base
	belongs_to :student
	has_many :feedback_receiveds
	has_many :feedback_givens
end
