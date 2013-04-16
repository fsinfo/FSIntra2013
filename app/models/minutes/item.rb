# == Schema Information
#
# Table name: minutes_items
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  content    :text
#  minute_id  :integer
#  created_at :datetime
#  updated_at :datetime
#  order      :integer
#

class Minutes::Item < ActiveRecord::Base
	belongs_to :minute

	validates_presence_of :title, :content, :on => :update
end
