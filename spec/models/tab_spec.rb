require 'spec_helper'

describe Tab do
  it "has an invoice greater than 0" do
    tab = FactoryGirl.build :tab, :with_beverage_tabs
    tab.beverage_tabs = []
    expect(tab).to be_invalid
  end
end