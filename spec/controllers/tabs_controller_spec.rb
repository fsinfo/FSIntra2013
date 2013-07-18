require 'spec_helper'

describe TabsController do
  describe 'normal user' do
  end

  describe 'kuehlschrank-user' do
    before :each do
      @user = FactoryGirl.create(:user, :kuehlschrank)
      login @user
    end

    describe "GET edit" do
      it "should be a success" do
        tab = FactoryGirl.create(:tab)
        get :edit, id: tab.id
        response.should be_success 
      end

      it "should assign the tab as @tab" do
        tab = FactoryGirl.create(:tab)
        get :edit, id: tab.id
        assigns(:tab).should eq(tab)
      end
    end
  end
end
