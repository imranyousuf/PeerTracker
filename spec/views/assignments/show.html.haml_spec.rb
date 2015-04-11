require 'rails_helper'

RSpec.describe "assignments/show", type: :view do
  before(:each) do
    @assignment = assign(:assignment, Assignment.create!(
      :assignment_name => "Assignment Name",
      :course => "Course"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Assignment Name/)
    expect(rendered).to match(/Course/)
  end
end
