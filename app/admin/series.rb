ActiveAdmin.register Series do

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
    column :description
    column :number
    actions
  end

  filter :name
  filter :duration
  filter :release_date

  form do |f|
    f.inputs do
      f.input :name
      f.input :description, as: :text
      f.input(:season, as: :searchable_select)
      f.input :number
      f.input :image
    end
    f.actions
  end
  
  permit_params do
    permitted = [:name, :description, :image, :number, :season_id]
    permitted << :other if params[:action] == 'create' && current_user.admin?
    permitted
  end
  
end
