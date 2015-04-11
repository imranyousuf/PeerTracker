require 'rails_helper'

RSpec.describe "assignments/index", type: :view do
  before(:each) do
    assign(:assignments, [
      Assignment.create!(
        :assignment_name => "Assignment Name",
        :course => "Course"
      ),
      Assignment.create!(
        :assignment_name => "Assignment Name",
        :course => "Course"
      )
    ])
  end

  it "renders a list of assignments" do
    render
    assert_select "tr>td", :text => "Assignment Name".to_s, :count => 2
    assert_select "tr>td", :text => "Course".to_s, :count => 2
  end
end
