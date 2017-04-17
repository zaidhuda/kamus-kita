class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  protected

  def current_or_guest_user
    if current_user
      if session[:guest_user_id] && session[:guest_user_id] != current_user.id
        belongings_handover
        guest_user(with_retry = false).reload.try(:destroy)
        session[:guest_user_id] = nil
      end
      current_user
    else
      guest_user
    end
  end

  def guest_user(with_retry = true)
    @cached_guest_user ||= User.find(session[:guest_user_id] ||= create_guest_user.id)
  rescue ActiveRecord::RecordNotFound
     session[:guest_user_id] = nil
     if with_retry
       guest_user
     else
      authenticate_user!
    end
  end
  
  def current_user_or_anonymous
    current_user || User.friendly.find('anonymous'.freeze)
  rescue ActiveRecord::RecordNotFound
    authenticate_user!
  end

  private

  def belongings_handover
    if guest = guest_user(with_retry = false)
      definitions = guest.definitions
      definitions.update_all(:user_id, current_user.id)      
    end
  end

  def create_guest_user
    u = User.create_guest_user
    session[:guest_user_id] = u.id
    u
  end
end
