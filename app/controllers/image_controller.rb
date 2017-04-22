class ImageController < ApplicationController
  layout false
  def show
    @definition = Definition.find(params[:id])
  end
end
