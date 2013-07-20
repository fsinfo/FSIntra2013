require 'spec_helper'

describe Beverage do
  it "should always have a price" do
    bev = FactoryGirl.build(:beverage, price: nil) 
    bev.should be_invalid
  end
end
