class Team < ActiveRecord::Base
	has_and_belongs_to_many :users
	belongs_to :course
	belongs_to :instructor
end
