module ApplicationHelper
  def default_meta_tags
    {
      site: 'KamusKita',
      title: '',
      reverse: true,
      description: 'We define our culture'
    }
  end

  def guest_user_id_session
    session[:guest_user_id]  
  end
end
