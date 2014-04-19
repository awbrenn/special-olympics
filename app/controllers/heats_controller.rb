class HeatsController < ApplicationController
  before_action :set_heat, only: [:show, :edit, :update, :destroy]

  # GET /heats
  # GET /heats.json
  def index
    @heats = Heat.all
  end

  # GET /heats/1
  # GET /heats/1.json
  def show
  end

  # GET /heats/new
  def new
    @heat = Heat.new
  end

  # GET /heats/1/edit
  def edit
  end

  # POST /heats
  # POST /heats.json
  def create
    @heat = Heat.new(heat_params)

    respond_to do |format|
      if @heat.save
        format.html { redirect_to @heat, notice: 'Heat was successfully created.' }
        format.json { render action: 'show', status: :created, location: @heat }
      else
        format.html { render action: 'new' }
        format.json { render json: @heat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /heats/1
  # PATCH/PUT /heats/1.json
  def update
    respond_to do |format|
      if @heat.update(heat_params)
        format.html { redirect_to @heat, notice: 'Heat was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @heat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /heats/1
  # DELETE /heats/1.json
  def destroy
    @heat.destroy
    respond_to do |format|
      format.html { redirect_to heats_url }
      format.json { head :no_content }
    end
  end


  # Imports a file to pass to heat model
  def import
    Heat.import(params[:file])
    redirect_to heats_path, notice: "Heats imported."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_heat
      @heat = Heat.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def heat_params
      params.require(:heat).permit(:event_id, :gender, :min_age, :max_age, :time, :num_heats)
    end
end
