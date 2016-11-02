require "rails_helper"

RSpec.describe VehicleinfosController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/vehicleinfos").to route_to("vehicleinfos#index")
    end

    it "routes to #new" do
      expect(:get => "/vehicleinfos/new").to route_to("vehicleinfos#new")
    end

    it "routes to #show" do
      expect(:get => "/vehicleinfos/1").to route_to("vehicleinfos#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/vehicleinfos/1/edit").to route_to("vehicleinfos#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/vehicleinfos").to route_to("vehicleinfos#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/vehicleinfos/1").to route_to("vehicleinfos#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/vehicleinfos/1").to route_to("vehicleinfos#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/vehicleinfos/1").to route_to("vehicleinfos#destroy", :id => "1")
    end

  end
end
