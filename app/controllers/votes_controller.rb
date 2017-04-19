class VotesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_definition, except: :index

  def index
    @definition = Definition.includes(:word).where.not(id: current_user.votes.pluck(:definition_id)).take(1).first
  end

  def like
    @definition.liked_by current_user
    redirect_to vote_path
  end

  def dislike
    @definition.disliked_by current_user
    redirect_to vote_path
  end

  def ignore
    @definition.ignored_by current_user
    redirect_to vote_path
  end

  private

  def set_definition
    @definition = Definition.find(params[:id])
  end
end
