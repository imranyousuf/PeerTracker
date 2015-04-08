require 'rails_helper'

RSpec.describe "students/index", type: :view do
  before(:each) do
    assign(:students, [
      Student.create!(
        :name => "MyText",
        :email => "MyText",
        :quiz1 => 1,
        :quiz2 => 2,
        :quiz3 => 3,
        :overall => "MyText"
      ),
      Student.create!(
        :name => "MyText",
        :email => "MyText",
        :quiz1 => 1,
        :quiz2 => 2,
        :quiz3 => 3,
        :overall => "MyText"
      )
    ])
  end

  it "renders a list of students" do
    render
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
