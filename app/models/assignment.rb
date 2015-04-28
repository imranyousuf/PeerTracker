class Assignment < ActiveRecord::Base
	belongs_to :course
	has_many :feedbacks
    validates :assignment_name, uniqueness: { message: "An assignment with that name already exists"}
end
