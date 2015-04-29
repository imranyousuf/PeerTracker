class Assignment < ActiveRecord::Base
	belongs_to :course
	has_many :feedbacks
    validates :assignment_name, uniqueness: { scope: :course_id, message: "An assignment with that name already exists"}
end
