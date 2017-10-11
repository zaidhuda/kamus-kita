module DefinitionsHelper
  def a2a_title definition
    "#{definition.original_word} | KamusKita"
  end

  def new_word_definition_path
    case controller_name
    when 'words'
      new_definition_path(word: params[:id])
    when 'definitions'
      new_definition_path(word: params[:word_id])
    when 'search'
      new_definition_path(word: params[:q])
    else
      new_definition_path
    end
  end

  def parse_linked_words definition, link_options={}
    definition.gsub(/\[.*?\]/){ |s|
      word = s[1..s.size-2] if s.size > 2
      if word
        # link_to word, word_path(id: word.parameterize), link_options
        content_tag(:span, word, class: 'kamuskita')
      end
    }.html_safe
  end

  def fake_parse_linked_words definition
    definition.gsub(/\[.*?\]/){ |s|
      word = s[1..s.size-2] if s.size > 2
      if word
        "<a>#{word}</a>"
      end
    }.html_safe
  end

  def facebook_link text, url
    "https://www.facebook.com/sharer/sharer.php?t=#{text}&u=#{url}"
  end

  def twitter_link text, url
    "https://twitter.com/intent/tweet?text=#{text}&url=#{url}&hashtags=kamuskita"
  end
end
