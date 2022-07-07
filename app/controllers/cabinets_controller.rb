class CabinetsController < ApplicationController
  before_action :set_cabinet, only: %i[ show edit update destroy ]

  # GET /cabinets or /cabinets.json
  def index
    @cabinets = Cabinet.all
  end

  # GET /cabinets/1 or /cabinets/1.json
  def show
  end

  # GET /cabinets/new
  def new
    @cabinet = Cabinet.new
  end

  # GET /cabinets/1/edit
  def edit
  end

  # POST /cabinets or /cabinets.json
  def create
    @cabinet = Cabinet.new(cabinet_params)

    respond_to do |format|
      if @cabinet.save
        format.html { redirect_to cabinet_url(@cabinet), notice: "Cabinet was successfully created." }
        format.json { render :show, status: :created, location: @cabinet }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @cabinet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cabinents/1 or /cabinents/1.json
  def update
    respond_to do |format|
      if @cabinet.update(cabinet_params)
        format.html { redirect_to cabinet_url(@cabinet), notice: "Cabinet was successfully updated." }
        format.json { render :show, status: :ok, location: @cabinet }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @cabinet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cabinets/1 or /cabinets/1.json
  def destroy
    @cabinet.destroy

    respond_to do |format|
      format.html { redirect_to cabinets_url, notice: "Cabinet was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cabinet
      @cabinet = Cabinet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def cabinet_params
      params.require(:cabinet).permit(:name)
    end
end
