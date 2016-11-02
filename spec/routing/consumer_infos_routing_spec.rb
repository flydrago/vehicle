require "rails_helper"

RSpec.describe ConsumerInfosController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/consumer_infos").to route_to("consumer_infos#index")
    end

    it "routes to #new" do
      expect(:get => "/consumer_infos/new").to route_to("consumer_infos#new")
    end

    it "routes to #show" do
      expect(:get => "/consumer_infos/1").to route_to("consumer_infos#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/consumer_infos/1/edit").to route_to("consumer_infos#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/consumer_infos").to route_to("consumer_infos#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/consumer_infos/1").to route_to("consumer_infos#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/consumer_infos/1").to route_to("consumer_infos#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/consumer_infos/1").to route_to("consumer_infos#destroy", :id => "1")
    end

  end
end
