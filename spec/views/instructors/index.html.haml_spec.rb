require 'rails_helper'

RSpec.describe "instructors/index", type: :view do
  before(:each) do
    assign(:instructors, [
      Instructor.create!(
        :name => "MyText",
        :sid => "MyText",
        :email => "MyText",
        :teams => "MyText"
      ),
      Instructor.create!(
        :name => "MyText",
        :sid => "MyText",
        :email => "MyText",
        :teams => "MyText"
      )
    ])
  end

  it "renders a list of instructors" do
    render
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
