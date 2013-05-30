require 'spec_helper'

describe User do
  it "has an email" do
    user = FactoryGirl.build(:user)
    user.email = ''
    expect(user).to be_invalid
  end
end