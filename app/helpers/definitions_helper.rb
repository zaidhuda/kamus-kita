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
        link_to word, word_path(id: word.parameterize), link_options
      end
    }.html_safe
  end
end
