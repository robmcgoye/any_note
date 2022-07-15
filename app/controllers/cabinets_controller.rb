class CabinetsController < ApplicationController
  before_action only: [:new, :create] do
    set_account
    require_allowed_user(@account)
  end

  # def index
  #   @cabinets = Cabinet.all
  # end

  # # GET /cabinets/1 or /cabinets/1.json
  # def show
  # end

  # GET /cabinets/new
  def new
    @cabinet = @account.cabinets.new
    @cabinet.folders.new
  end

  # # GET /cabinets/1/edit
  # def edit
  # end

  # POST /cabinets or /cabinets.json
  def create
    @cabinet = @account.cabinets.build(cabinet_params)
    respond_to do |format|
      if @cabinet.save
        format.html { redirect_to new_folder_note_path(@cabinet.folders.take), notice: "Cabinet was successfully created." }
        format.json { render :show, status: :created, location: @cabinet }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @cabinet.errors, status: :unprocessable_entity }
      end
    end
  end

  # # PATCH/PUT /cabinents/1 or /cabinents/1.json
  # def update
  #   respond_to do |format|
  #     if @cabinet.update(cabinet_params)
  #       format.html { redirect_to cabinet_url(@cabinet), notice: "Cabinet was successfully updated." }
  #       format.json { render :show, status: :ok, location: @cabinet }
  #     else
  #       format.html { render :edit, status: :unprocessable_entity }
  #       format.json { render json: @cabinet.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # DELETE /cabinets/1 or /cabinets/1.json
  # def destroy
  #   @cabinet.destroy

  #   respond_to do |format|
  #     format.html { redirect_to cabinets_url, notice: "Cabinet was successfully destroyed." }
  #     format.json { head :no_content }
  #   end
  # end

  private

    def set_account
      @account = Account.find(params[:account_id])
    end

    def set_cabinet
      @cabinet = Cabinet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def cabinet_params
      params.require(:cabinet).permit(:name, folders_attributes: [:id, :title, :_destroy])
    end
end