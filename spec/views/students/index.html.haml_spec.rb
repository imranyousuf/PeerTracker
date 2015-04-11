require 'rails_helper'

RSpec.describe "students/index", type: :view do
  before(:each) do
    assign(:students, [
      Student.create!(
      :name => "MyText",
      :sid => "MyText",
      :email => "MyText",
      :instructor => "MyText",
      :team => "MyText"
      ),
      Student.create!(
      :name => "MyText",
      :sid => "MyText",
      :email => "MyText",
      :instructor => "MyText",
      :team => "MyText"
      )
    ])
  end

  it "renders a list of students" do
    render
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2

  end
end
