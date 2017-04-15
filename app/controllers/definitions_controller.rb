class DefinitionsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :create, :destroy]
  before_action :set_definition, only: [:edit, :update, :destroy]

  def show
    @definition = Definition.find(params[:id])
  end

  def new
    @definition = current_user.definitions.new
  end

  def edit
  end

  def create
    @definition = current_user.definitions.new(definition_params)

    respond_to do |format|
      if @definition.save
        format.html { redirect_to @definition, notice: 'Definition was successfully created.' }
        format.json { render :show, status: :created, location: @definition }
      else
        format.html { render :new }
        format.json { render json: @definition.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @definition.update(definition_params)
        format.html { redirect_to @definition, notice: 'Definition was successfully updated.' }
        format.json { render :show, status: :ok, location: @definition }
      else
        format.html { render :edit }
        format.json { render json: @definition.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @definition.destroy
    respond_to do |format|
      format.html { redirect_to definitions_url, notice: 'Definition was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_definition
      @definition = current_user.definitions.find(params[:id])
    end

    def definition_params
      params.require(:definition).permit(:word_word, :definition, :example)
    end
end
