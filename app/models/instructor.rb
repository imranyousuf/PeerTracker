class Instructor < ActiveRecord::Base
    def self.import(file)
        CSV.foreach(file.path, headers: true) do |row|
            Instructor.create! row.to_hash
        end
    end
end
