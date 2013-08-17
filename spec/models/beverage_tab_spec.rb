# == Schema Information
#
# Table name: beverage_tabs
#
#  id         :integer          not null, primary key
#  tab_id     :integer
#  count      :integer
#  price      :decimal(8, 2)
#  created_at :datetime
#  updated_at :datetime
#  name       :string(255)
#  capacity   :decimal(8, 2)
#

require 'spec_helper'

describe BeverageTab do 
  it "should always have a count greater than 0" do
    bev = FactoryGirl.build(:beverage_tab, count: -1)
    bev.should be_invalid
  end
end
  
