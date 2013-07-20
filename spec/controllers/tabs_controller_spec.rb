require 'spec_helper'

describe TabsController do
  describe 'as normal user' do
    before :each do
      @user = FactoryGirl.create(:user)
      login @user
    end

    describe "GET index" do
      let(:running_tab) { FactoryGirl.create(:tab, :running, user_id: @user.id) }
      let(:paid_tab1) { FactoryGirl.create(:tab, :paid, user_id: @user.id) }
      let(:paid_tab2) { FactoryGirl.create(:tab, :paid, user_id: @user.id) }
      let(:unpaid_tab1) { FactoryGirl.create(:tab, :unpaid, user_id: @user.id) }
      let(:unpaid_tab2) { FactoryGirl.create(:tab, :unpaid, user_id: @user.id) }

      it "should assign the running_tab as @running_tab" do
        running_tab
        get :index
        expect(assigns(:running_tab)).to eq(running_tab)
      end

      it "should assign the paid tabs as @paid_tabs" do
        get :index
        expect(assigns(:paid_tabs)).to match_array([paid_tab1, paid_tab2])
      end

      it "should assign the unpaid tabs as @unpaid_tabs" do
        get :index
        expect(assigns(:unpaid_tabs)).to match_array([unpaid_tab1, unpaid_tab2])
      end

    end

    describe "GET unpaid" do
      it "should raise CanCan::AccessDenied" do
        expect{get :unpaid}.to raise_error(CanCan::AccessDenied)
      end
    end

    # CORRECT_USER
    context 'correct user' do
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

    # WRONG USER
    context 'wrong user' do
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

  # KUEHLSCHRANK USER
  context 'as kuehlschrank-user' do
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
      context "valid parameters" do
        before :each do
          @tab = FactoryGirl.create(:tab)
          @attributes = FactoryGirl.build(:tab, :with_beverage_tabs).attributes
          put :update, id: @tab.id, tab: @attributes
        end

        it "should update the tab" do
          pending "TODO: Find a way to test this"
        end

        it "should redirect to @tab" do
          response.should redirect_to(action: :show, id: @tab.id)
        end
      end

      context "invalid parameters" do
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

    describe "GET unpaid" do
      it "should assign unpaid tabs as @tabs" do
        tab1 = FactoryGirl.create(:tab, :unpaid)
        tab2 = FactoryGirl.create(:tab, :unpaid)
        tab3 = FactoryGirl.create(:tab, :marked_as_paid)
        tab4 = FactoryGirl.create(:tab, :marked_as_paid)
        FactoryGirl.create(:tab, :paid)

        get :unpaid
        expect(assigns(:tabs)).to match_array([tab1,tab2,tab3,tab4])
      end
    end

    describe "PUT/PATCH pay" do
      before :each do
        @tab = FactoryGirl.create(:tab)
      end

      it "should render feedback for json" do
        put :pay, id: @tab.id, format: :json
        response.should be_success
      end

      it "should redirect to unpaid tabs for html" do
        put :pay, id: @tab.id, format: :html
        response.should redirect_to(action: :unpaid)
      end

      it "should send an email" do
        pending "TODO"
      end
    end
  end
end
