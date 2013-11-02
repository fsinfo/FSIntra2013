require "spec_helper"

describe Minutes::MinutesController do
  describe "routing" do

    it "routes to #index" do
      get("/minutes/minutes").should route_to("minutes/minutes#index")
    end

    it "routes to #new" do
      get("/minutes/minutes/new").should route_to("minutes/minutes#new")
    end

    it "routes to #show" do
      get("/minutes/minutes/1").should route_to("minutes/minutes#show", :id => "1")
    end

    it "routes to #edit" do
      get("/minutes/minutes/1/edit").should route_to("minutes/minutes#edit", :id => "1")
    end

    it "routes to #create" do
      post("/minutes/minutes").should route_to("minutes/minutes#create")
    end

    it "routes to #update" do
      put("/minutes/minutes/1").should route_to("minutes/minutes#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/minutes/minutes/1").should route_to("minutes/minutes#destroy", :id => "1")
    end

  end
end
