class Team < ActiveRecord::Base
    require 'csv'
	has_and_belongs_to_many :users, :join_table => :teams_users
	belongs_to :course
	belongs_to :instructor

   def self.import(file)
       CSV.foreach(file.path, headers: true) do |row|
           Team.create! row.to_hash
       end
   end
    
end
