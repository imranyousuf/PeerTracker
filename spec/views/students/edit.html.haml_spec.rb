require 'rails_helper'

RSpec.describe "students/edit", type: :view do
  before(:each) do
    @student = assign(:student, Student.create!(
      :name => "MyText",
      :email => "MyText",
      :quiz1 => 1,
      :quiz2 => 1,
      :quiz3 => 1,
      :overall => "MyText"
    ))
  end

  it "renders the edit student form" do
    render

    assert_select "form[action=?][method=?]", student_path(@student), "post" do

      assert_select "textarea#student_name[name=?]", "student[name]"

      assert_select "textarea#student_email[name=?]", "student[email]"

      assert_select "input#student_quiz1[name=?]", "student[quiz1]"

      assert_select "input#student_quiz2[name=?]", "student[quiz2]"

      assert_select "input#student_quiz3[name=?]", "student[quiz3]"

      assert_select "textarea#student_overall[name=?]", "student[overall]"
    end
  end
end
