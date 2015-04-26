class AddTeamIdtoFeedbacks < ActiveRecord::Migration
  def change
    add_column :feedbacks, :team_id, :integer
  end
end
