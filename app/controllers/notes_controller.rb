class NotesController < ApplicationController
  before_action only: [:new, :create] do
    set_cabinet
    require_allowed_user(@account)
  end
  before_action only: [:show, :edit, :update, :destroy] do
    set_note
    require_allowed_user(@account)
  end

  def show
  end

  def new
    @note = Note.new
  end

  def edit
  end

  def create
    # binding.break
    @note = Note.new(note_params)   
    respond_to do |format|
      if @note.save
        format.html { redirect_to note_url(@note), notice: "Note was successfully created." }
        # format.json { render :show, status: :created, location: @note }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @note.update(note_params)
        format.html { redirect_to note_url(@note), notice: "Note was successfully updated." }
        # format.json { render :show, status: :ok, location: @note }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @note.destroy
    respond_to do |format|
      format.html { redirect_to back_to_cabinet_path(@cabinet.id), notice: "Note was successfully deleted." }
      format.json { head :no_content }
    end
  end

  private
    def set_cabinet
      @cabinet = Cabinet.find(params[:cabinet_id])
      @account = @cabinet.account
    end

    def set_note
      @note = Note.find(params[:id])
      @folder = @note.folder
      @cabinet = @folder.cabinet
      @account = @cabinet.account
      cookie_name = "#{@account.id}_cabinet_#{@cabinet.id}"
      cookies[cookie_name] = @note.id
  end

    def note_params
      params.require(:note).permit(:title, :content, :folder_id)
    end
  
end
