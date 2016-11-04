require "rails_helper"

RSpec.describe DistriProductInfosController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/distri_product_infos").to route_to("distri_product_infos#index")
    end

    it "routes to #new" do
      expect(:get => "/distri_product_infos/new").to route_to("distri_product_infos#new")
    end

    it "routes to #show" do
      expect(:get => "/distri_product_infos/1").to route_to("distri_product_infos#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/distri_product_infos/1/edit").to route_to("distri_product_infos#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/distri_product_infos").to route_to("distri_product_infos#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/distri_product_infos/1").to route_to("distri_product_infos#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/distri_product_infos/1").to route_to("distri_product_infos#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/distri_product_infos/1").to route_to("distri_product_infos#destroy", :id => "1")
    end

  end
end
