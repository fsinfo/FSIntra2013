class Minutes::ApprovementsController < ApplicationController
  before_action :set_minute
  before_action :set_minutes_approvement, only: [:show, :edit, :update, :destroy]

  def new
  	@minutes = Minutes::Minute.not_approved
  	@minutes_approvement = Minutes::Approvement.new
  end

  def edit

  end

  def create
  	@minutes_approvement = @minutes_minute.approvements.build(minutes_approvement_params)

    respond_to do |format|
      if @minutes_approvement.save
        format.html { redirect_to @minutes_minute, notice: 'Item was successfully created.' }
        format.json { render action: 'show', status: :created, location: @minutes_minute }
      else
        format.html { render action: 'new' }
        format.json { render json: @minutes_approvement.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @minutes_approvement.update(minutes_approvement_params)
        format.html { redirect_to @minutes_minute, notice: 'Item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @minutes_approvement.errors, status: :unprocessable_entity }
      end
    end
  end


  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def minutes_approvement_params
      params.require(:minutes_approvement).permit(:approved_minute_id, :pro, :con, :abs, :apparent_majority, :approved)
    end

    def set_minute
      @minutes_minute = Minutes::Minute.find(params[:minute_id])
    end

    def set_minutes_approvement
      @minutes_approvement = Minutes::Approvement.find(params[:id])
    end
end
