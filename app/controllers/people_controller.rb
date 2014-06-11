class PeopleController < ApplicationController
  before_action :signed_in_user
  load_and_authorize_resource

  def index
    if params[:tag]
      @search = Person.tagged_with(params[:tag]).search(params[:q])
    else
      @search = Person.search(params[:q])
      @search.sorts = 'lastname asc' if @search.sorts.empty?
    end
    @people = @search.result
  end

  def show
    respond_to do |format|
      format.html
      format.vcf do
        send_data @person.to_vcard, :filename => "#{@person.id} - #{@person.displayed_name}.vcf"
      end
      format.svg  { render :qrcode => @person.to_vcard, :level => :h, :unit => 1, :offset => 5 }
      format.png { render qrcode: @person.to_vcard }
    end
  end

  def new
    @person = Person.new
  end

  def edit
  end

  def create
    @person = Person.new(person_params)

    if @person.save
      redirect_to @person, notice: t('feedback.created', :model => Person.model_name.human)
    else
      render action: 'new'
    end
  end

  def update
    if @person.update(person_params)
      redirect_to @person, notice: t('feedback.updated', :model => Person.model_name.human)
    else
      render action: 'edit'
    end
  end

  def destroy
    @person.destroy
    redirect_to action: 'index', notice: t('feedback.destroyed', model: Person.model_name.human)
  end

  private
    def person_params
      params.require(:person).permit(:firstname, :lastname, :street, :zip, :city, :email, :phone, :birthday, :misc, :tag_list)
    end
end
