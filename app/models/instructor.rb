class Instructor < ActiveRecord::Base
	has_many :teams
	belongs_to :course

    def self.import(file)
        CSV.foreach(file.path, headers: true) do |row|
            Instructor.create! row.to_hash
        end
    end
end
