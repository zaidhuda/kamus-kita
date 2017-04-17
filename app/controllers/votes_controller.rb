class VotesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_definition

  def like
    respond_to do |format|
      if @definition.liked_by current_user
        format.html { redirect_to word_definition_path(@definition.word, @definition), notice: 'Definition was liked.' }
        format.json { render :show, status: :ok, location: word_definition_path(@definition.word, @definition) }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @definition.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  def dislike
    respond_to do |format|
      if @definition.disliked_by current_user
        format.html { redirect_to word_definition_path(@definition.word, @definition), notice: 'Definition was disliked.' }
        format.json { render :show, status: :ok, location: word_definition_path(@definition.word, @definition) }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @definition.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  private

  def set_definition
    @definition = Definition.includes(:word).find(params[:id])
  end
end
