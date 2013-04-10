# == Schema Information
#
# Table name: minutes_guests
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Minutes::Guest < ActiveRecord::Base
end
