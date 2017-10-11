class Api::WordsController < Api::BaseController
  def index
    words = Word.order(created_at: :desc).includes(best_definition: :user).page params[:page]
    render json: words.as_json(only: [:id, :word])
  end

  def show
    word = Word.includes(:best_definition).friendly.find(params[:id].parameterize)
    definitions = Definition.where(word_id: word.id)
                    .includes(:user, :word)
                    .order(likes_counter: :desc, created_at: :desc)
                    .page params[:page]
    render json: definitions
  end

  def best_definition
    definition = Word.includes(:best_definition).friendly.find(params[:id]).best_definition
    render json: definition.as_json(only: [:id, :original_word, :definition, :example])
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
