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
end
