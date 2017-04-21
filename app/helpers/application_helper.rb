module ApplicationHelper
  def default_meta_tags
    {
      site: 'KamusKita',
      title: '',
      reverse: true,
      description: 'Kamus sempoi untuk bahasa borak',
      image: "#{root_url}apple-icon.png",
      twitter: {
        card: "summary",
        title: :title,
        description: :description,
        image: { _: "#{root_url}apple-icon.png" }
      }
    }
  end

  def guest_user_id_session
    session[:guest_user_id]  
  end
end
