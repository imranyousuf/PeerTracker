class Course < ActiveRecord::Base
	has_many :instructors
	has_many :assignments
	has_and_belongs_to_many :students
	has_many :teams
	belongs_to :professor
	has_one :credential
end