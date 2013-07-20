require 'spec_helper'

describe BeverageTab do 
  it "should always have a count greater than 0" do
    bev = FactoryGirl.build(:beverage_tab, count: -1)
    bev.should be_invalid
  end
end
  