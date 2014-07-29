# == Schema Information
#
# Table name: tabs
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#  status     :string(255)      default("running")
#

class Tab < ActiveRecord::Base
	STATUSES = [STATUS_PAID = 'paid', STATUS_UNPAID = 'unpaid', STATUS_RUNNING = 'running']
	has_many :beverage_tabs, :dependent => :delete_all
	belongs_to :user

	scope :paid, -> { where(status: Tab::STATUS_PAID) }
	scope :unpaid, -> { where(status: Tab::STATUS_UNPAID) }
	scope :running, -> { where(status: Tab::STATUS_RUNNING) }
	validates :status, inclusion: {in: STATUSES}
	validate :only_one_running_tab_per_user

	before_save :delete_empty_beverage_tabs

	accepts_nested_attributes_for :beverage_tabs

	def is_running?
		self.status == Tab::STATUS_RUNNING
	end

	def is_unpaid?
		self.status == Tab::STATUS_UNPAID
	end

	def paid
		self.status = Tab::STATUS_PAID
	end

	def is_paid?
		self.status == Tab::STATUS_PAID
	end

	def total_invoice
		self.beverage_tabs.sum("count * price")
	end

	def grouped_beverage_tabs
		self.beverage_tabs.group(:name, :capacity, :price).sum(:count)
	end

	private
	def only_one_running_tab_per_user
		other = Tab.find_by(user_id: user_id, status: Tab::STATUS_RUNNING)
		if other.present? and self != other and self.status == Tab::STATUS_RUNNING
			errors.add(:status, 'There can be only one running tab per user')
		end
	end

	def delete_empty_beverage_tabs
		self.beverage_tabs.each do |bt|
			bt.destroy if bt.count == 0
		end
	end
end
