class TallySheetsController < ApplicationController
  before_action :signed_in_user
  authorize_resource :class => false
  before_action :get_users, only: [:print_users]
  before_action :get_beverages, only: [:print_items]

  def index 
    @tabs = Tab.running
    @beverage_tabs = BeverageTab.where(tab_id: @tabs).select(:name, :price, :capacity).distinct
    @users = User.includes(:tabs).where(tabs: {status: Tab::STATUS_RUNNING}) | User.where(on_beverage_list: true)
    @data = {}
    @users.each do |user|
      tab = @tabs.find_by(user: user)
      @data[user] = []
      unless tab.nil?
        @beverage_tabs.each_with_index do |bt,j|
          @data[user][j] = tab.beverage_tabs.where(name: bt.name, price: bt.price, capacity: bt.capacity).sum(:count)
        end
      else
        @beverage_tabs.each_with_index do |bt,j|
          @data[user][j] = 0
        end
      end
    end
  end

  # send mails where the tabs' invoice is greater than 0.0
  # remove tabs that have an invoice == 0
  def accounting
    # delete empty tabs 
    @tabs = Tab.running
    ActiveRecord::Base.transaction do
      @tabs.each do |tab|
        tab.destroy unless tab.total_invoice > 0
      end
    end

    # change status from running to unpaid
    Tab.running.update_all(:status => Tab::STATUS_UNPAID)

    # send a mail for every unpaid tab
    Tab.unpaid.each do |tab|
      TabMailer.tab_email(tab).deliver
    end

    redirect_to unpaid_tabs_path
  end

  def edit
    @new_candidates = User.all.where(:on_beverage_list => false)
    @delete_candidates = User.all.where(:on_beverage_list => true)
  end

  def update
    User.where(:id => params['new']).update_all(:on_beverage_list => true)
    User.where(:id => params['delete']).update_all(:on_beverage_list => false)
    redirect_to tally_sheet_edit_url, notice: t('.updated')
  end

  def print_users
    respond_to do |format|
      format.pdf do
        render :pdf => "Benutzerliste.pdf"
      end
    end
  end

  def print_items
    @items = Beverage.available
    respond_to do |format|
      format.pdf do 
        render :pdf => "Preisliste.pdf"
      end
    end
  end

  private
    def get_users
      @search = User.where(:on_beverage_list => true).order('lastname, firstname').search(params[:q])
      @users = @search.result
    end

    def get_beverages
      @beverages = Beverage.available
    end

    def tally_sheet_params
      params[:tabs]
    end
  end
