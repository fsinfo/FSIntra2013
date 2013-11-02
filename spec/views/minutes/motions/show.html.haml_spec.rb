require 'spec_helper'

describe "minutes/motions/show" do
  before(:each) do
    @minutes_motion = assign(:minutes_motion, stub_model(Minutes::Motion,
      :order => 1,
      :mover => nil,
      :pro => 2,
      :con => 3,
      :abs => 4,
      :rationale => "MyText",
      :amount => 5,
      :minutes_item => nil,
      :approved => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(//)
    rendered.should match(/2/)
    rendered.should match(/3/)
    rendered.should match(/4/)
    rendered.should match(/MyText/)
    rendered.should match(/5/)
    rendered.should match(//)
    rendered.should match(/false/)
  end
end
