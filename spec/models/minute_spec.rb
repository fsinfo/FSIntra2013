# == Schema Information
#
# Table name: minutes
#
#  id                       :integer          not null, primary key
#  date                     :datetime
#  status                   :string(255)      default("draft")
#  created_at               :datetime
#  updated_at               :datetime
#  keeper_of_the_minutes_id :integer
#  chairperson_id           :integer
#

require 'spec_helper'

describe Minute do
  it "whatthefuckdidjusthappen" do
    minute = FactoryGirl.build :minute
    puts minute.keeper_of_the_minutes
  end
end
