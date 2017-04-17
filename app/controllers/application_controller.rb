class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  protected
  
  def current_user_or_anonymous
    current_user || User.friendly.find('anonymous'.freeze)
  rescue ActiveRecord::RecordNotFound
    authenticate_user!
  end
end
