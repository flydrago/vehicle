require "rails_helper"

RSpec.describe CashPurchasesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/cash_purchases").to route_to("cash_purchases#index")
    end

    it "routes to #new" do
      expect(:get => "/cash_purchases/new").to route_to("cash_purchases#new")
    end

    it "routes to #show" do
      expect(:get => "/cash_purchases/1").to route_to("cash_purchases#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/cash_purchases/1/edit").to route_to("cash_purchases#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/cash_purchases").to route_to("cash_purchases#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/cash_purchases/1").to route_to("cash_purchases#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/cash_purchases/1").to route_to("cash_purchases#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/cash_purchases/1").to route_to("cash_purchases#destroy", :id => "1")
    end

  end
end
