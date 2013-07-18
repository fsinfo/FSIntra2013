require 'spec_helper'

describe Person do
  describe "birthday" do
    context "birthday is later in the year" do
      it "calculates the correct birthday" do

        pending "hurr durr"

        start_date = Time.new(2013,7,18)
        birthday = Date.new(2013,12,1)
        @person = FactoryGirl.create(:person, birthday: birthday) 
        @person.time_to_next_birthday.should eq(birthday.to_time - start_date)
      end
    end

    context "next birthday is today" do
      it "calculates the correct birthday" do

        pending "hurr durr"

        start_date = Time.new(2013,7,18)
        birthday = Date.new(2013,7,18)
        @person = FactoryGirl.create(:person, birthday: birthday) 
        @person.time_to_next_birthday.should eq(birthday.to_time - start_date)
      end
    end

    context "birthday was already this year" do
      it "calculates the correct birthday" do

        pending "hurr durr"

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
  end
end