require 'spec_helper'

describe ApiController do
  let!(:beverage1) {FactoryGirl.create(:beverage)}
  let!(:beverage2) {FactoryGirl.create(:beverage)}
  let!(:unavailable_beverage) {FactoryGirl.create(:unavailable_beverage)}
  let(:user) { FactoryGirl.create(:user_on_beverage_list) }

  context "correct authentication information" do
    include AuthHelper
    before(:each) do
      http_login
    end

    # params[:buy] => {:user => loginname, :beverages => { $id => $count, 3 => 4}}
    describe "PUT/PATCH buy" do
      context "user has no running tab yet" do
        let(:count1) { 2 }
        let(:count2) { 1 }
        let(:buy_params) { { :user => user.loginname, :beverages => { beverage1.id => count1 , beverage2.id => count2 } } }

        it "is a success" do
          put :buy, buy: buy_params
          response.should be_successful
        end

        it "increases the count" do
          put :buy, buy: buy_params
          tab = Tab.find_by(user_id: user.id, status: Tab::STATUS_RUNNING)
          bt1 = tab.beverage_tabs.find_by(name: beverage1.name, price: beverage1.price)
          bt1.count.should eq(count1)
          bt2 = tab.beverage_tabs.find_by(name: beverage2.name, price: beverage2.price)
          bt2.count.should eq(count2)
        end
      end
    end

    describe "GET items" do
      it "should return all available items" do
        get :items, format: :json
        response.body.should eq([beverage1,beverage2].to_json)
      end
    end
  end

  context "wrong authentication information" do
    describe "POST buy" do
      it "should not be successful" do
        get :items, format: :json
        response.should_not be_successful
      end
    end

    describe "GET items" do
      it "should not be successful" do
        get :items, format: :json
        response.should_not be_successful
      end
    end
  end
end