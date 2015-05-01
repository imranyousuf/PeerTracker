class AddTeamSizeToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :team_size, :integer, default: 4
  end
end
