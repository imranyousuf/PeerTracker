require 'rails_helper'
require 'database_cleaner'
require 'action_dispatch/testing/test_process'
DatabaseCleaner.strategy = :truncation

RSpec.describe Team, type: :model do
	
	before(:each) do
	    DatabaseCleaner.clean
	    @student1 = create(:student)
	    @course = create(:course)
  		@file = fixture_file_upload('files/team.csv', 'text/csv')
  		@file_invalid1 = fixture_file_upload('files/invalid.csv', 'text/csv')
  	end

	describe "test import for students on a team" do
   		context "with valid csv file" do
   			it "saves the right students" do 
   				Team.import(@file, @course.id, @student1)
   				@team = Team.where(:course_id => @course.id).first
   				@team.users.should include(@student1)
	   		end
   		end
   		context "with csv file lacking student" do
   			it "adds the appropriate error" do
   				all_errors = Team.import(@file_invalid1, @course.id, @student1)
   				all_errors.should include("Student with SID: 30000000 does not exist")
   			end
   		end
   		context "with csv file for already existing team" do 
   			it "adds the appropriate error" do
   				@existing_team = create(:team)
   				all_errors = Team.import(@file_invalid1, @course.id, @student1)
   				all_errors.should include("Team name dogs who code exists")
   			end
   		end
   	end
end