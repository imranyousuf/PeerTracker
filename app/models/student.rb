class Student < ActiveRecord::Base
	devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
	
	has_and_belongs_to_many :teams
	has_and_belongs_to_many :courses
	has_many :assignments, through :feedback_receiveds
	has_many :feedback_givens
	has_many :feedback_receiveds

	def self.import(file)
		CSV.foreach(file.path, headers: true) do |row|
			Student.create! row.to_hash
		end
	end
end
