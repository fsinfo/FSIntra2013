# == Schema Information
#
# Table name: beverages
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  description        :text
#  available          :boolean
#  price              :decimal(8, 2)
#  created_at         :datetime
#  updated_at         :datetime
#  capacity           :decimal(8, 2)
#  external_price     :decimal(8, 2)
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#

class Beverage < ActiveRecord::Base
	include ActionView::Helpers::NumberHelper
	validates :name, :presence => true, uniqueness: {scope: :price}
	validates :price, :numericality => {:greater_than => 0}
	validates :external_price, :numericality => {:greater_than => 0}
	validates :capacity, :numericality => {:greater_than => 0}

	has_attached_file :image, :styles => { :large => "400x400>", :small => "100x100>" }, :default_url => "/images/__missing.png"
	validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
	validates_attachment_size :image, { :in => 0..1024.kilobytes }

	scope :available, -> { where :available => true }

	def image_url
		image.url
	end

	def to_s
		"#{self.name} (#{number_to_currency self.price} / #{number_to_human self.capacity, :separator => ',', :significant => false, :precision => 2, :units => {:unit => 'l'}})"
	end
end
