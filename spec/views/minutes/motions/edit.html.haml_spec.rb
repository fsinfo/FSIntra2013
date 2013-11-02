require 'spec_helper'

describe "minutes/motions/edit" do
  before(:each) do
    @minutes_motion = assign(:minutes_motion, stub_model(Minutes::Motion,
      :order => 1,
      :mover => nil,
      :pro => 1,
      :con => 1,
      :abs => 1,
      :rationale => "MyText",
      :amount => 1,
      :minutes_item => nil,
      :approved => false
    ))
  end

  it "renders the edit minutes_motion form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", minutes_motion_path(@minutes_motion), "post" do
      assert_select "input#minutes_motion_order[name=?]", "minutes_motion[order]"
      assert_select "input#minutes_motion_mover[name=?]", "minutes_motion[mover]"
      assert_select "input#minutes_motion_pro[name=?]", "minutes_motion[pro]"
      assert_select "input#minutes_motion_con[name=?]", "minutes_motion[con]"
      assert_select "input#minutes_motion_abs[name=?]", "minutes_motion[abs]"
      assert_select "textarea#minutes_motion_rationale[name=?]", "minutes_motion[rationale]"
      assert_select "input#minutes_motion_amount[name=?]", "minutes_motion[amount]"
      assert_select "input#minutes_motion_minutes_item[name=?]", "minutes_motion[minutes_item]"
      assert_select "input#minutes_motion_approved[name=?]", "minutes_motion[approved]"
    end
  end
end
