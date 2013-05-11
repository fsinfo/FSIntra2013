class PeopleController < ApplicationController
  before_action :set_person, only: [:show, :edit, :update]
  before_action :signed_in_user

  def index
    @people = Person.all
  end

  def show
    respond_to do |format| 
      format.html
      format.vcf do 
        send_data @person.to_vcard, :filename => "#{@person.id} - #{@person.displayed_name}.vcf"
      end
      format.svg  { render :qrcode => @person.to_vcard, :level => :h, :unit => 1, :offset => 5 }
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
      redirect_to @person, notice: 'Contact was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @person.update(person_params)
      redirect_to @person, notice: 'Contact was successfully updated.'
    else
      render action: 'edit'
    end
  end

  private
    def set_person
      @person = Person.find(params[:id])
    end

    def person_params 
      params.require(:person).permit(:firstname, :lastname, :street, :zip, :city, :email, :phone, :birthday, :misc)
    end
end
