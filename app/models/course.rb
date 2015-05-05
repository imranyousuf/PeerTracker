class Course < ActiveRecord::Base
	has_many :assignments
	has_and_belongs_to_many :users, :join_table => :courses_users
	has_many :teams
	has_one :credential
  validates :course_name, uniqueness: { message: "Course name exists"}
  validate :format_name

  def format_name
    if /[A-Z]{1,} [0-9A-Z]+/.match(course_name) == nil
      errors.add(:course_name, "Incorrect format. i.e. CS 162")
    end
  end
end
