# == Schema Information
#
# Table name: beverages
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  available   :boolean
#  price       :decimal(8, 2)
#  created_at  :datetime
#  updated_at  :datetime
#

class Beverage < ActiveRecord::Base
	has_many :beverage_tabs
	has_many :tabs, :through => :beverage_tabs

	validates :name, :presence => true
	validates :price, :numericality => {:greater_than => 0}, :presence => true

	scope :available, -> { where :available => true }
end
