class VotesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_definition

  def like
    respond_to do |format|
      if @definition.liked_by current_user
        format.html { redirect_to @definition, notice: 'Definition was liked.' }
        format.json { render :show, status: :ok, location: @definition }
      else
        format.html { render :edit }
        format.json { render json: @definition.errors, status: :unprocessable_entity }
      end
    end
  end

  def dislike
    respond_to do |format|
      if @definition.disliked_by current_user
        format.html { redirect_to @definition, notice: 'Definition was disliked.' }
        format.json { render :show, status: :ok, location: @definition }
      else
        format.html { render :edit }
        format.json { render json: @definition.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_definition
    @definition = Definition.find params[:id]
  end
end
