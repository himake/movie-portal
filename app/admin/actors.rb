ActiveAdmin.register Actor do

  controller do
    before_action :show
    def show
      redirect_to admin_root_path unless current_user.admin? || current_user.editor?
    end
  end

  index do
    selectable_column
    id_column
    column :full_name
    column :biography
    column :date_of_birth
    column :place_of_birth
    actions
  end

  filter :full_name
  filter :place_of_birth

  form do |f|
    f.inputs do
      f.input :full_name
      f.input :place_of_birth
      f.input :biography, as: :text
      f.input :date_of_birth, label: 'Date of birth', as: :datepicker
      f.input :image
    end
    f.actions
  end

  permit_params do
    permitted = %i[full_name biography date_of_birth image place_of_birth]
    permitted << :other if params[:action] == 'create' && current_user.admin?
    permitted
  end
end
