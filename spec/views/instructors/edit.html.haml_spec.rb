require 'rails_helper'

RSpec.describe "instructors/edit", type: :view do
  before(:each) do
    @instructor = assign(:instructor, Instructor.create!(
      :name => "MyText",
      :sid => "MyText",
      :email => "MyText",
      :teams => "MyText"
    ))
  end

  it "renders the edit instructor form" do
    render

    assert_select "form[action=?][method=?]", instructor_path(@instructor), "post" do

      assert_select "textarea#instructor_name[name=?]", "instructor[name]"

      assert_select "textarea#instructor_sid[name=?]", "instructor[sid]"

      assert_select "textarea#instructor_email[name=?]", "instructor[email]"

      assert_select "textarea#instructor_teams[name=?]", "instructor[teams]"
    end
  end
end
