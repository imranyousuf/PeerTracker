class AddTeamIdtoFeedbacks < ActiveRecord::Migration
  def change
    add_reference :feedbacks, :assignment, index: true
    add_reference :feedbacks, :team, index: true
  end
end
