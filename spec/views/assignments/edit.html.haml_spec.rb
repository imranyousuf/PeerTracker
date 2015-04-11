require 'rails_helper'

RSpec.describe "assignments/edit", type: :view do
  before(:each) do
    @assignment = assign(:assignment, Assignment.create!(
      :assignment_name => "MyString",
      :course => "MyString"
    ))
  end

  it "renders the edit assignment form" do
    render

    assert_select "form[action=?][method=?]", assignment_path(@assignment), "post" do

      assert_select "input#assignment_assignment_name[name=?]", "assignment[assignment_name]"

      assert_select "input#assignment_course[name=?]", "assignment[course]"
    end
  end
end
