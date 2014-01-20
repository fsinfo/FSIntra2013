# == Schema Information
#
# Table name: people
#
#  id               :integer          not null, primary key
#  firstname        :string(255)
#  lastname         :string(255)
#  street           :string(255)
#  zip              :string(255)
#  city             :string(255)
#  email            :string(255)
#  phone            :string(255)
#  birthday         :date
#  misc             :text
#  loginname        :string(255)
#  remember_token   :string(255)
#  type             :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#  on_beverage_list :boolean          default(FALSE)
#  cached_tag_list  :string(255)
#

# == Schema Information
#
# Table name: people
#
#  id               :integer          not null, primary key
#  firstname        :string(255)
#  lastname         :string(255)
#  street           :string(255)
#  zip              :string(255)
#  city             :string(255)
#  email            :string(255)
#  phone            :string(255)
#  birthday         :date
#  misc             :text
#  loginname        :string(255)
#  remember_token   :string(255)
#  type             :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#  on_beverage_list :boolean          default(FALSE)
#
require 'spec_helper'

describe User do
  it "has an email" do
    user = FactoryGirl.build(:user)
    user.email = ''
    expect(user).to be_invalid
  end

  it "has a unique email" do
    user = FactoryGirl.create(:user)
    user2 = FactoryGirl.build(:user, email: user.email)
    expect(user2).to be_invalid
  end

  it "calculates the right debts" do
    user = FactoryGirl.create(:user)
    tab1 = FactoryGirl.create(:tab, :unpaid, user_id: user.id)
    bt = FactoryGirl.create(:beverage_tab, price: 5, count: 1)
    tab1.beverage_tabs = [bt]

    tab2 = FactoryGirl.create(:tab, :unpaid, user_id: user.id)
    bt1 = FactoryGirl.create(:beverage_tab, price: 1, count: 10)
    bt2 = FactoryGirl.create(:beverage_tab, price: 1, count: 10)
    tab2.beverage_tabs = [bt1, bt2]
    
    tab3 = FactoryGirl.create(:tab, :marked_as_paid, user_id: user.id)
    bt3 = FactoryGirl.create(:beverage_tab, price: 1, count: 1000)
    tab3.beverage_tabs = [bt]

    expect(user.debts).to eq(25)
  end

  it "should return users with group 'fsr'" do
    user1 = FactoryGirl.create(:user, :fsr)
    user2 = FactoryGirl.create(:user, :fsr)
    user3 = FactoryGirl.create(:user)

    expect(User.fsr).to match_array([user1,user2])
  end
end
