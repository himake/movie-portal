ActiveAdmin.register Serial do

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
    column(:release_date) { |serial| serial.release_date&.strftime('%d-%m-%Y') }
    column 'Category' do |serial|
      Category.find(serial.category_id)
    end
    column 'Director' do |serial|
      Director.find(serial.director_id)
    end
    actions
  end

  filter :name
  filter :duration
  filter :release_date

  form do |f|
    f.inputs do
      f.input :name
      f.input :description, as: :text
      f.input :release_date, label: 'Released date', as: :datepicker
      f.input(:category, as: :searchable_select)
      f.input(:director, as: :searchable_select)
      f.input :video_key
      f.input :image
    end
    f.actions
  end

  permit_params do
    permitted = [:name, :description, :video_key, :release_date, :category_id, :director_id, :image]
    permitted << :other if params[:action] == 'create' && current_user.admin?
    permitted
  end
  
end
