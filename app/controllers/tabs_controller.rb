class TabsController < ApplicationController
	before_action :signed_in_user
  load_and_authorize_resource

  def index
    @running_tab = current_user.tabs.running.first
    @unpaid_tabs = current_user.tabs.unpaid 
    @paid_tabs = current_user.tabs.paid
  end

  def show
    @beverage_tabs = @tab.beverage_tabs
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
    @user = @tab.user
    TabMailer.paid_email(@tab) if @tab.save
    respond_to do |format|
      format.json { render :json => {:feedback => t('.paid_tab', name: @tab.user.displayed_name, total: @tab.total_invoice)} }
      format.html { redirect_to unpaid_tabs_path }
    end
  end

  def mark_as_paid
    @tab.status = 'marked_as_paid'
    respond_to do |format|
      if @tab.save
        TabMailer.marked_as_paid_email(@tab)
        format.js {}
        format.html {redirect_to @tab}
      else
        format.html {render :edit}
      end
    end
  end

  def unpaid
    @tabs = Tab.unpaid.includes(:beverage_tabs, :user).order('people.firstname','people.lastname') 
  end

  private
    def tab_params
      params.require(:tab).permit(:paid)
    end
end
