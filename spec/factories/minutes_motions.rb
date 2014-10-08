# == Schema Information
#
# Table name: minutes_motions
#
#  id                :integer          not null, primary key
#  order             :integer
#  mover_id          :integer
#  pro               :integer
#  con               :integer
#  abs               :integer
#  rationale         :text
#  amount            :integer
#  item_id           :integer
#  approved          :boolean
#  created_at        :datetime
#  updated_at        :datetime
#  apparent_majority :boolean
#
# Indexes
#
#  index_minutes_motions_on_item_id   (item_id)
#  index_minutes_motions_on_mover_id  (mover_id)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :minutes_motion, :class => 'Minutes::Motion' do
    order 1
    mover nil
    pro 1
    con 1
    abs 1
    rationale "MyText"
    amount 1
    minutes_item nil
    approved false
  end
end
