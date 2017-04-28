ActiveAdmin.register Word do
  permit_params :hidden, :word

  controller do
    def find_resource
      scoped_collection.friendly.find(params[:id])
    end
  end

  form do |f|
    f.inputs :word, :hidden
    f.actions
  end
end
