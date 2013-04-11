class PeopleController < ApplicationController
  before_action :set_person, only: [:show, :edit, :update]
  before_action :signed_in_user

  # GET /users
  def index
    @people = Person.all
  end

  # GET /users/1
  def show
  end

  # GET /users/new
  def new
    @person = Person.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  def create
    @person = Person.new(person_params)

    if @person.save
      redirect_to @person, notice: 'Person was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /users/1
  def update
    if @person.update(person_params)
			login @person
      redirect_to @person, notice: 'User was successfully updated.'
    else
      render action: 'edit'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_person
      @person = Person.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def person_params 
      params.require(:person).permit(:firstname, :lastname, :street, :zip, :city, :email, :phone, :birthday, :misc)
    end
end
