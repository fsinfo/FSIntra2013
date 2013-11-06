# == Schema Information
#
# Table name: minutes_items
#
#  id         :integer          not null, primary key
#  date       :date
#  title      :string(255)
#  content    :text
#  order      :integer
#  minute_id  :integer
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_minutes_items_on_minute_id  (minute_id)
#

class Minutes::Item < ActiveRecord::Base
  belongs_to :minute, class_name: 'Minutes::Minute'
  has_many :motions, class_name: 'Minutes::Motion'

  validates_presence_of :order

  def move_up
    other = Minutes::Item.where(minute: minute).where(order: order-1).first
    if other
      other.order = order
      self.order = order - 1
      other.save
      self.save
    end
  end

  def move_down
    other = Minutes::Item.where(minute: minute).where(order: order+1).first
    if other
      other.order = self.order
      self.order = self.order + 1
      other.save
      self.save
    end
  end
end
