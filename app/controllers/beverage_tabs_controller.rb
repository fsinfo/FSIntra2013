class BeverageTabsController < ApplicationController
  before_action :signed_in_user
  authorize_resource

  def create
    @tab = Tab.find(params[:tab_id])
    if @tab.user_id == current_user.id
      @beverage = Beverage.find(params[:beverage_id])
      @tab.beverage_tabs << BeverageTab.create(count: 1, name: @beverage.name, capacity: @beverage.capacity, price: @beverage.price)
      @tab.save
    else
      raise CanCan::AccessDenied.new("Not authorized")
    end

    redirect_to edit_tab_path(@tab)
  end
end
