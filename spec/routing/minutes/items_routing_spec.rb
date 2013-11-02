require "spec_helper"

describe Minutes::ItemsController do
  describe "routing" do

    it "routes to #index" do
      get("/minutes/items").should route_to("minutes/items#index")
    end

    it "routes to #new" do
      get("/minutes/items/new").should route_to("minutes/items#new")
    end

    it "routes to #show" do
      get("/minutes/items/1").should route_to("minutes/items#show", :id => "1")
    end

    it "routes to #edit" do
      get("/minutes/items/1/edit").should route_to("minutes/items#edit", :id => "1")
    end

    it "routes to #create" do
      post("/minutes/items").should route_to("minutes/items#create")
    end

    it "routes to #update" do
      put("/minutes/items/1").should route_to("minutes/items#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/minutes/items/1").should route_to("minutes/items#destroy", :id => "1")
    end

  end
end
