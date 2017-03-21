class CleanersController < ApplicationController
  before_action :set_cleaner, only: [:show, :edit, :update, :destroy]

  # GET /cleaners
  # GET /cleaners.json
  def index
    @cleaners = Cleaner.all
  end

  # GET /cleaners/1
  # GET /cleaners/1.json
  def show
    @cleaner_city = City.find(@selected_cities.pluck(:city_id))
  end

  # GET /cleaners/new
  def new
    @cleaner = Cleaner.new
    @cities = City.all
  end

  # GET /cleaners/1/edit
  def edit
    @cities = City.all
  end

  # POST /cleaners
  # POST /cleaners.json
  def create
    @cleaner = Cleaner.new(cleaner_params)
    if @cleaner.save
      @selected_cities = params[:city_ids]
      @selected_cities.each do |city|
        @cities_cleaner = CitiesCleaner.create(city_id: city,cleaner_id: Cleaner.last.id)
      end
      redirect_to action: 'index'
    else
      render 'new'
    end
  end

  # PATCH/PUT /cleaners/1
  # PATCH/PUT /cleaners/1.json
  def update
     if @cleaner.update(cleaner_params)
       CitiesCleaner.where(cleaner_id: @cleaner.id).destroy_all
       @selected_cities = params[:city_ids]
       @selected_cities.each do |city|
         CitiesCleaner.create(city_id: city,cleaner_id: @cleaner.id)
       end
       redirect_to action: 'index'
     else
       render 'edit'
     end
  end

  # DELETE /cleaners/1
  # DELETE /cleaners/1.json
  def destroy
    @cleaner.destroy
    respond_to do |format|
      format.html { redirect_to cleaners_url, notice: 'Cleaner was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cleaner
      @cleaner = Cleaner.find(params[:id])
      @selected_cities = CitiesCleaner.where(cleaner_id: params[:id]).select(:city_id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cleaner_params
      params.require(:cleaner).permit(:first_name, :last_name, :quality_score, :email)
    end
end
