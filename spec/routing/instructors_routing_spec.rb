require "rails_helper"

RSpec.describe InstructorsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/instructors").to route_to("instructors#index")
    end

    it "routes to #new" do
      expect(:get => "/instructors/new").to route_to("instructors#new")
    end

    it "routes to #show" do
      expect(:get => "/instructors/1").to route_to("instructors#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/instructors/1/edit").to route_to("instructors#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/instructors").to route_to("instructors#create")
    end

    it "routes to #update" do
      expect(:put => "/instructors/1").to route_to("instructors#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/instructors/1").to route_to("instructors#destroy", :id => "1")
    end

  end
end
