class Api::DefinitionsController < Api::BaseController
  def index
    head 501
  end
  
  def show
    render json: Definition.find(params[:id])
  end
  
  def new
    head 501
  end
  
  def create
    head 501
  end
  
  def update
    head 501
  end
  
  def desroy
    head 501
  end
end
