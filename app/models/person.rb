# == Schema Information
#
# Table name: people
#
#  id             :integer          not null, primary key
#  firstname      :string(255)
#  lastname       :string(255)
#  street         :string(255)
#  zip            :string(255)
#  city           :string(255)
#  email          :string(255)
#  phone          :string(255)
#  birthday       :date
#  misc           :text
#  loginname      :string(255)
#  remember_token :string(255)
#  type           :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#

class Person < ActiveRecord::Base
end
