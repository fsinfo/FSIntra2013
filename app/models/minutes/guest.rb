# == Schema Information
#
# Table name: minutes_guests
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_minutes_guests_on_name  (name) UNIQUE
#

class Minutes::Guest < ActiveRecord::Base
	validates :name, :uniqueness => true
end
