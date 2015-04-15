class Team < ActiveRecord::Base
	has_and_belongs_to_many :students
	belongs_to :course
	belongs_to :instructor
end