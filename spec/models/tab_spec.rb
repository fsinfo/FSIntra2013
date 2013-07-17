# == Schema Information
#
# Table name: tabs
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#  status     :string(255)      default("running")
#

require 'spec_helper'

describe Tab do
  it "can only be one running tab per user" do
    tab = FactoryGirl.create :tab
    tab2 = FactoryGirl.build :tab, user: tab.user
    expect(tab2).to be_invalid
  end
end
