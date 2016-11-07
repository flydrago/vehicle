require "rails_helper"

RSpec.describe DistributorsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/distributors").to route_to("distributors#index")
    end

    it "routes to #new" do
      expect(:get => "/distributors/new").to route_to("distributors#new")
    end

    it "routes to #show" do
      expect(:get => "/distributors/1").to route_to("distributors#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/distributors/1/edit").to route_to("distributors#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/distributors").to route_to("distributors#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/distributors/1").to route_to("distributors#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/distributors/1").to route_to("distributors#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/distributors/1").to route_to("distributors#destroy", :id => "1")
    end

  end
end
