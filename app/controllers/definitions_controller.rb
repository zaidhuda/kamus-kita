class DefinitionsController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :destroy]
  before_action :set_definition, only: [:edit, :update, :destroy]

  def show
    @definition = Definition.find(params[:id])

    set_meta_tags title: @definition.original_word,
                  description: @definition.definition.truncate(140)
  end

  def new
    @definition = Definition.new
  end

  def edit
  end

  def create
    @definition = current_or_guest_user.definitions.new(definition_params)

    respond_to do |format|
      if @definition.save
        format.html { redirect_to word_definition_path(@definition.word, @definition), notice: 'Definition was successfully created.' }
        format.json { render :show, status: :created, location: word_definition_path(@definition.word, @definition) }
      else
        format.html { render :new }
        format.json { render json: @definition.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @definition.update(definition_params)
        format.html { redirect_to word_definition_path(@definition.word, @definition), notice: 'Definition was successfully updated.' }
        format.json { render :show, status: :ok, location: word_definition_path(@definition.word, @definition) }
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
      params.require(:definition).permit(:original_word, :definition, :example)
    end
end
