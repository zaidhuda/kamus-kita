class UsersController < ApplicationController
  layout "devise", only: [:edit]

  def show
    @user = User.friendly.find(params[:id])
    @words = Word.where(
      id: Definition
        .where(user_id: @user.id)
        .uniq(:word_id)
        .pluck(:word_id)
      )
      .includes(best_definition: :user)
      .page params[:page]
  end

  def edit
  end

  def update
    respond_to do |format|
      if current_user.update(user_params)
        format.html { redirect_to edit_user_path, notice: 'Handle was successfully updated.' }
        format.json { render :show, status: :created, location: current_user }
      else
        format.html { render :new }
        format.json { render json: current_user.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:handle)
  end
end
