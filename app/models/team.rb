class Team < ActiveRecord::Base
    require 'csv'
	has_and_belongs_to_many :users, :join_table => :teams_users
	has_many :feedbacks
  belongs_to :course
	belongs_to :instructor
  validates :name, uniqueness: { case_sensitive: false, scope: :course_id, message: "Team name exists"}

   def self.import(file)
       CSV.foreach(file.path, headers: true) do |row|
           Team.create! row.to_hash
       end
   end
    
end
