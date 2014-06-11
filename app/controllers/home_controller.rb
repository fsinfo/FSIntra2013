require 'beverage_stats'
class HomeController < ApplicationController
  before_action :signed_in_user

  def index
    @unpaid_tabs = current_user.tabs.unpaid
    @birthday_people = Person.all.sort_by(&:days_to_next_birthday).first(5)
  end
end
