class ApplicationController < ActionController::Base
  include ApplicationHelper
  protect_from_forgery with: :exception

  def current_or_guest_user
    if current_user
      if guest_user_id_session && guest_user_id_session != current_user.id
        belongings_handover
        guest_user(with_retry = false).reload.try(:destroy)
        session.delete(:guest_user_id)
      end
      current_user
    else
      guest_user
    end
  end
  helper_method :current_or_guest_user

  protected

  def guest_user(with_retry = true)
    @cached_guest_user ||= User.find(session[:guest_user_id] ||= create_guest_user.id)
  rescue ActiveRecord::RecordNotFound
     session.delete(:guest_user_id)
     if with_retry
       guest_user
     else
      authenticate_user!
    end
  end

  def display_aside
    @display_aside = true
  end

  private

  def belongings_handover
    if guest = guest_user(with_retry = false)
      definitions = guest.definitions
      definitions.update_all(user_id: current_user.id)      
    end
  end

  def create_guest_user
    u = User.create_guest_user
    session[:guest_user_id] = u.id
    u
  end
end
