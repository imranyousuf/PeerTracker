require 'rails_helper'

RSpec.describe "assignments/new", type: :view do
  before(:each) do
    assign(:assignment, Assignment.new(
      :assignment_name => "MyString",
      :course => "MyString"
    ))
  end

  it "renders new assignment form" do
    render

    assert_select "form[action=?][method=?]", course_team_assignments_path, "post" do

      assert_select "input#assignment_assignment_name[name=?]", "assignment[assignment_name]"

      assert_select "input#assignment_course[name=?]", "assignment[course]"
    end
  end
end
