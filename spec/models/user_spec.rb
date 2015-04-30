require 'rails_helper'
require 'database_cleaner'
DatabaseCleaner.strategy = :truncation

RSpec.describe User, type: :model do
	
	before(:each) do
	    DatabaseCleaner.clean
	    @student = create(:student)
	    @assignment = create(:assignment)
	    @feedback_1 = create(:feedback1)
	    @feedback_1.receiver_id = 30000001
	    @feedback_1.rating = 25
	    @feedback_2 = create(:feedback2)
	    @feedback_2.receiver_id = 30000001
	    @feedback_2.rating = 15
	    @assignment.feedbacks << @feedback_1
	    @assignment.feedbacks << @feedback_2
  	end

	describe "test get average for a student" do
   		context "with feedbacks" do
   			it "gets correct average" do 
	   			@student.average_rating(@assignment).to_i.should eq(20)
	   		end
   		end
   		context "without any feedbacks" do
   			it "returns no feedback received" do
   				@feedback_1.destroy
   				@feedback_2.destroy
   				@student.average_rating(@assignment).should eq("No feedback received")
   			end
   		end
   	end
end