class DropFeedbackGivensFeedbackReceiveds < ActiveRecord::Migration
  def change
  	drop_table :feedback_givens
  	drop_table :feedback_receiveds
  	create_table :feedbacks do |t|
  		t.string :comments
  		t.integer :rating
  		t.integer :giver_id
  		t.integer :receiver_id
  	end
  end
end
