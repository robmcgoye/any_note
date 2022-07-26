class FoldersController < ApplicationController
  before_action only: [:new, :create] do
    set_cabinet
    require_allowed_user(@account)
  end
  before_action only: [:edit, :update, :destroy] do
    set_folder
    require_allowed_user(@account)
  end

  def new
    @folder = @cabinet.folders.new
  end

  def edit
  end

  def create
    @folder = @cabinet.folders.build(folder_params)
    respond_to do |format|
      if @cabinet.save
        format.html { redirect_to back_to_cabinet_path(@cabinet.id), notice: "Folder was successfully created." }
        # format.json { render :show, status: :created, location: @folder }
      else
        format.html { render :new, status: :unprocessable_entity }
        # format.json { render json: @folder.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @folder.update(folder_params)
        format.html { redirect_to back_to_cabinet_path(@cabinet.id), notice: "Folder was successfully updated." }
        # format.json { render :show, status: :ok, location: @folder }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @folder.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @folder.destroy
    respond_to do |format|
      format.html { redirect_to back_to_cabinet_path(@cabinet.id), notice: "Folder was successfully deleted." }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_folder
    @folder = Folder.find_by id: params[:id]
    @cabinet = @folder.cabinet
    set_parent
  end

  def set_parent
    @account = @cabinet.account
  end

  def set_cabinet
    @cabinet = Cabinet.find_by id: params[:cabinet_id]
    set_parent
  end

  # Only allow a list of trusted parameters through.
  def folder_params
    params.require(:folder).permit(:title)
  end

end