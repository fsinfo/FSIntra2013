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

require 'spec_helper'

describe Person do
  describe "birthday" do
    context "birthday is later in the year" do
      it "calculates the correct birthday" do

        pending "TODO: find a better way to test"

        start_date = Time.new(2013,7,18)
        birthday = Date.new(2013,12,1)
        @person = FactoryGirl.create(:person, birthday: birthday) 
        @person.time_to_next_birthday.should eq(birthday.to_time - start_date)
      end
    end

    context "next birthday is today" do
      it "calculates the correct birthday" do

        pending "TODO: find a better way to test"

        start_date = Time.new(2013,7,18)
        birthday = Date.new(2013,7,18)
        @person = FactoryGirl.create(:person, birthday: birthday) 
        @person.time_to_next_birthday.should eq(birthday.to_time - start_date)
      end
    end

    context "birthday was already this year" do
      it "calculates the correct birthday" do

        pending "TODO: find a better way to test"

        start_date = Time.new(2013,7,18)
        birthday = Date.new(2014,1,1)
        @person = FactoryGirl.create(:person, birthday: birthday) 
        @person.time_to_next_birthday.should eq(birthday.to_time - start_date)
      end
    end
  end

  describe "vcard" do
    it "should not throw an error" do
      @person = FactoryGirl.create(:person)
      expect{@person.to_vcard}.to_not raise_error
    end

    it "should return an empty string if unencodable" do
      @person = Person.new
      @person.to_vcard.should eq("")
    end
  end

  describe "short_name" do
    it "should return the full lastname and the first letter of the firstname" do
      @person = FactoryGirl.build(:person, firstname: 'Hurr', lastname: 'Durr')
      @person.short_name.should eq("H. Durr")
    end
  end
end
