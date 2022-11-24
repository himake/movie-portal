ActiveAdmin.register Category do

  controller do
    before_action :show
    def show
      redirect_to admin_root_path unless current_user.admin? || current_user.editor?
    end
  end

  index do
    selectable_column
    id_column
    column :name
    actions
  end

  filter :name

  form do |f|
    f.inputs do
      f.input :name
    end
    f.actions
  end

  permit_params do
    permitted = [:name]
    permitted << :other if params[:action] == 'create' && current_user.admin?
    permitted
  end
end
