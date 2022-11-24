ActiveAdmin.register Comment do

  controller do
    before_action :show
    def show
      redirect_to admin_root_path unless current_user.admin? || current_user.editor?
    end
  end

  index do
    selectable_column
    id_column
    column :body
    column :user_id
    actions
  end

  filter :body
  filter :user_id

  form do |f|
    f.inputs do
      f.input :body
    end
    f.actions
  end

  permit_params do
    permitted = %i[body]
    permitted << :other if params[:action] == 'create' && current_user.admin?
    permitted
  end
end
