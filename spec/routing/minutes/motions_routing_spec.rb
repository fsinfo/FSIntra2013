require "spec_helper"

describe Minutes::MotionsController do
  describe "routing" do

    it "routes to #index" do
      get("/minutes/motions").should route_to("minutes/motions#index")
    end

    it "routes to #new" do
      get("/minutes/motions/new").should route_to("minutes/motions#new")
    end

    it "routes to #show" do
      get("/minutes/motions/1").should route_to("minutes/motions#show", :id => "1")
    end

    it "routes to #edit" do
      get("/minutes/motions/1/edit").should route_to("minutes/motions#edit", :id => "1")
    end

    it "routes to #create" do
      post("/minutes/motions").should route_to("minutes/motions#create")
    end

    it "routes to #update" do
      put("/minutes/motions/1").should route_to("minutes/motions#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/minutes/motions/1").should route_to("minutes/motions#destroy", :id => "1")
    end

  end
end
