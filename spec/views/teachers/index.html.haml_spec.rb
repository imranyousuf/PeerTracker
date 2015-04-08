require 'rails_helper'

RSpec.describe "teachers/index", type: :view do
  before(:each) do
    assign(:teachers, [
      Teacher.create!(
        :name => "MyText",
        :email => "MyText",
        :score => "MyText"
      ),
      Teacher.create!(
        :name => "MyText",
        :email => "MyText",
        :score => "MyText"
      )
    ])
  end

  it "renders a list of teachers" do
    render
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
