class AddInstructionToAssignment < ActiveRecord::Migration
  def change
    add_column :assignments, :instructions, :string, default: "This form is an opportunity for you to rate the performance of your team members on this iteration.  Please fill this form out to the best of your abilities.  Letting us know of issues within your team (e.g. unequal distribution of work, people not cooperating with the rest of the team, etc) allows the staff to be aware of them and help you fix them. You have 20*X points to distribute, where X is the total number of members in your group. The idea is that if someone did an average amount of work, they would get 20 points.  The sum of all points you give to yourself and your teammates need to sum to 20*X. All of the numbers and comments you give are private and only viewable by the staff."
  end
end
