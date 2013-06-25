# == Schema Information
#
# Table name: tabs
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  created_at     :datetime
#  updated_at     :datetime
#  paid           :boolean
#  marked_as_paid :boolean
#  status         :string(255)      default("running")
#

require 'spec_helper'

describe Tab do
  it "has an invoice greater than 0" do
    tab = FactoryGirl.build :tab, :with_beverage_tabs
    tab.beverage_tabs = []
    expect(tab).to be_invalid
  end
end
