module ApplicationHelper
  def default_meta_tags
    {
      site: 'KamusKita',
      title: '',
      reverse: true,
      url: request.original_url,
      description: 'Kamus sempoi untuk bahasa borak',
      image: "#{root_url}apple-icon.png",
      fb: {
        app_id: "689597981228619"
      },
      og: {
        title:    :title,
        type:     'website',
        description: :description,
        image:    "#{root_url}apple-icon.png"
      },
      twitter: {
        card: 'summary',
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
