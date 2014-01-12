class HomeController < ApplicationController
  before_action :signed_in_user
  before_action :prepare_stats
  
  def index
    @running_tab = current_user.tabs.running.includes(:beverage_tabs).first
    @unpaid_tabs = current_user.tabs.unpaid.includes(:beverage_tabs) 
    @birthday_people = Person.all.sort_by(&:days_to_next_birthday).first(5)
  end

  private
    def prepare_stats
      @stat_data = []
      bts = BeverageTab.where("date(created_at) >= ? AND date(created_at) <= ?", Date.today - 7.days, Date.today)
      bt_data = {}
      bts.each do |bt|
        bt_data[bt.name] ||= {}
        bt_data[bt.name][bt.created_at.beginning_of_hour.to_i] ||= 0
        bt_data[bt.name][bt.created_at.beginning_of_hour.to_i] += bt.count
      end

      bt_data.each do |name,b|
        tmp_hash = {}
        tmp_array = []
        b.each do |k,v|
          tmp_array << {x: k, y: v}
        end
        tmp_array.sort_by!{ |k,v| k[:x] } 
        tmp_hash[:data] = tmp_array
        tmp_hash[:name] = name
        @stat_data << tmp_hash
      end
    end
end
