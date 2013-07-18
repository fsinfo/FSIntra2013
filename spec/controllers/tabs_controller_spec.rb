require 'spec_helper'

describe TabsController do
  describe 'as normal user' do
    before :each do
      @user = FactoryGirl.create(:user)
      login @user
    end

    describe 'correct user' do
      before :each do
        @tab = FactoryGirl.create(:tab, user_id: @user.id)
      end

      describe "GET edit" do
        it "should raise CanCan::AccessDenied" do
          expect{get :edit, id: @tab.id}.to raise_error(CanCan::AccessDenied)
        end
      end

      describe "PUT pay" do
        it "should raise CanCan::AccessDenied" do
          expect{put :pay, id: @tab.id}.to raise_error(CanCan::AccessDenied)
        end
      end

      describe "PUT mark_as_paid" do
        it "should redirect to tab" do
          put :mark_as_paid, id: @tab.id
          response.should redirect_to(@tab)
        end

        it "should render json" do
          put :mark_as_paid, id: @tab.id, format: :js
          response.should be_success
        end
      end
    end

    describe 'wrong user' do
      before :each do
        @other = FactoryGirl.create(:user)
        @tab = FactoryGirl.create(:tab, user_id: @other.id)
      end

      describe "GET edit" do
        it "should raise CanCan::AccessDenied" do
          expect{get :edit, id: @tab.id}.to raise_error(CanCan::AccessDenied)
        end
      end

      describe "PUT pay" do
        it "should raise CanCan::AccessDenied" do
          expect{put :pay, id: @tab.id}.to raise_error(CanCan::AccessDenied)
        end
      end

      describe "PUT mark_as_paid" do
        it "should redirect to tab" do
          expect{ put :mark_as_paid, id: @tab.id }.to raise_error(CanCan::AccessDenied)
        end

        it "should render json" do
          expect{ put :mark_as_paid, id: @tab.id, format: :js}.to raise_error(CanCan::AccessDenied)
        end
      end
    end
  end

  describe 'as kuehlschrank-user' do
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

    describe "PATCH/PUT update" do
      describe "valid parameters" do
        before :each do
          @attributes = FactoryGirl.attributes_for(:tab, :with_beverage_tabs)
        end
      end

      describe "invalid parameters" do
        before :each do
          @tab = FactoryGirl.create(:tab, :with_beverage_tabs)
          @attributes = FactoryGirl.attributes_for(:tab, :invalid ,:with_beverage_tabs)
        end

        it "should re-render edit" do
          put :update, tab: @attributes, id: @tab.id
          response.should render_template("edit")
        end
      end
    end
  end
end
