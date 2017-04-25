ActiveAdmin.register Definition do
  index do
    selectable_column
    id_column
    column "Word" do |definition|
      link_to "Word ##{definition.word.id}", admin_word_path(definition.word)
    end
    column :original_word
    column :likes_counter
    column :dislikes_counter
    column :hidden
    actions
  end
end
