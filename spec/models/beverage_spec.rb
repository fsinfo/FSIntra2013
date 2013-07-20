require 'spec_helper'

describe Beverage do
  it "should always have a price" do
    bev = FactoryGirl.build(:beverage, price: nil) 
    bev.should be_invalid
  end

  it "it is unique with name and price" do
    bev1 = FactoryGirl.create(:beverage, name: "Beverage", price: 1.0)
    bev2 = FactoryGirl.build(:beverage, name: bev1.name, price: bev1.price)
    bev2.should be_invalid
  end
end
