class TabsController < ApplicationController
	before_action :signed_in_user
  load_and_authorize_resource

  def index
    @running_tab = current_user.tabs.running.first
    @unpaid_tabs = current_user.tabs.unpaid
    @paid_tabs = current_user.tabs.paid
  end

  def show
  end

  def detail
  end

  def update
    if @tab.update(tab_params)
      redirect_to @tab, notice: t('feedback.updated', model: Tab.model_name.human)
    else
      render action: 'edit'
    end
  end

  def edit
    @beverage_tabs = @tab.beverage_tabs
  end

  def pay
    @tab.paid
    if @tab.save
      TabMailer.paid_email(@tab).deliver
      respond_to do |format|
        format.json { render :json => {:feedback => t('.paid_tab', name: @tab.user.displayed_name, total: @tab.total_invoice)} }
        format.html { redirect_to unpaid_tabs_path }
      end
    end
  end

  def destroy_beverage_tab

  end

  def mark_as_paid
    @tab.marked_as_paid
    respond_to do |format|
      if @tab.save
        TabMailer.marked_as_paid_email(@tab).deliver
        format.js {}
        format.html {redirect_to @tab}
      else
        format.html {render :edit}
      end
    end
  end

  def unpaid
    @tabs = Tab.unpaid.includes(:user, :beverage_tabs).order("people.lastname")
		@users = User.includes(:tabs).where(tabs: {status: Tab::STATUS_UNPAID}).distinct.map{|u| u.to_s} + ['bezahlt']
		@sum = @tabs.inject(0.0) {|sum, tab| sum += tab.total_invoice}
  end

	def running
		@tabs = Tab.running
		@users = User.includes(:tabs).where(tabs: {status: Tab::STATUS_RUNNING}).distinct.map{|u| u.to_s}
	end

  private
    def tab_params
      params.require(:tab).permit(:paid, :status, { :beverage_tabs_attributes => [:id, :count] } )
    end
end
