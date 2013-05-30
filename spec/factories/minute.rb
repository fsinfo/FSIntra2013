FactoryGirl.define do
  factory :minute do 
    date Date.new(2010, 11, 12)
    # TODO loltests
    #keeper_of_the_minutes FactoryGirl.build(:user) #FactoryGirl.create(:user)
    #chairperson FactoryGirl.build(:user) #FactoryGirl.create(:user)
  end
end