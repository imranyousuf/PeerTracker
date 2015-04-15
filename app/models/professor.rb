class Professor < ActiveRecord::Base
	has_many :courses
	has_many :students, through :courses
	has_many :instructors, through :courses
	has_many :assignments, through :courses	
end