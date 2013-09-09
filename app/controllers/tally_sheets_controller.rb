class TallySheetsController < ApplicationController
  before_action :signed_in_user
  authorize_resource :class => false
  before_action :get_users, only: [:print_users]
  before_action :get_beverages, only: [:print_items]
  before_action :get_tabs, only: [:edit, :update, :accounting]

  def edit
  end

  def update
    ActiveRecord::Base.transaction do
      tally_sheet_params.each do |key,tab_data|
        # delete the user_id from the hash so we don't iterate over it in tab_data.each
        user_id = tab_data.delete 'user_id'
        tab = Tab.running.includes(:beverage_tabs).find_or_initialize_by(user_id: user_id)

        tab_data.each do |k, user_bts|
          user_bts.each do |k, bt_attributes|
            # delete the count from the hash so we don't search by it
            count = (bt_attributes.delete 'count').to_i
            bt = tab.beverage_tabs.find_or_initialize_by(bt_attributes)
            if count == 0
              bt.destroy
            else
              bt.count = count
              bt.save
            end
          end
        end
        tab.save unless tab.new_record? and tab.total_invoice == 0.0
      end
    end
    redirect_to tally_sheet_url, notice: t('feedback.updated', :model => t('tally_sheet'))
  end

  # send mails where the tabs' invoice is greater than 0.0
  # remove tabs that have an invoice == 0
  def accounting
    ActiveRecord::Base.transaction do
      @tabs.each do |tab|
        if tab.total_invoice > 0
          TabMailer.tab_email(tab).deliver
        else
          tab.destroy
        end
      end
      Tab.running.update_all(:status => 'unpaid')
    end
    redirect_to unpaid_tabs_path
  end

  def edit_list
    @new_candidates = User.all.where(:on_beverage_list => false)
    @delete_candidates = User.all.where(:on_beverage_list => true)
  end

  def update_list
    User.where(:id => params['new']).update_all(:on_beverage_list => true)
    User.where(:id => params['delete']).update_all(:on_beverage_list => false)
    redirect_to tally_sheet_edit_list_url, notice: t('.updated')
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
    # TODO: sort tabs by username somehow
    def get_tabs
      ActiveRecord::Base.transaction do
        @tabs = []
        @beverage_tabs = {}
        get_users
        get_beverages
        @users.each do |user|
          # Find only running tabs or initialize them if there is none
          tab = user.tabs.find_or_initialize_by(status: 'running')
          @beverage_tabs[tab.id] = []
          # For every available beverage create a beverage_tab or find it by name,capacity and price
          @beverages.each do |beverage|
            @beverage_tabs[tab.id] << tab.beverage_tabs.find_or_initialize_by(name: beverage.name, capacity: beverage.capacity, price: beverage.price)
          end
          # Sort the beverage_tabs so they are always in the right order and fit to the table-headers
          @beverage_tabs[tab.id].sort_by(&:name)
          @tabs << tab
        end
      end
    end

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
